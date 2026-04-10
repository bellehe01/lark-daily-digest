#!/usr/bin/env bash
# lark_digest.sh — Lark Daily Digest v2
#
# Phase 1: Fetch all active chats (>=2 messages in window)
# Phase 2: Analyze in ONE Claude API call -> structured JSON
# Phase 3: Build compact Lark Interactive Card -> send via lark-cli

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

LARK_CLI="/opt/homebrew/bin/lark-cli"
LOG_DIR="$SCRIPT_DIR/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/digest-$(date '+%Y-%m-%d').log"
START_TIME=$(date +%s)

log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG_FILE" >&2; }

# ---------------------------------------------------------------------------
# Timeout guard: 15 minutes
# ---------------------------------------------------------------------------
(
  sleep 900
  log "TIMEOUT: script exceeded 15 minutes, killing..."
  if [[ -n "${LARK_USER_ID:-}" ]]; then
    "$LARK_CLI" im +messages-send \
      --user-id "$LARK_USER_ID" \
      --text "⚠️ Lark Daily Digest timed out after 15 minutes on $(date +%Y-%m-%d). Check logs." \
      --as bot 2>/dev/null || true
  fi
  kill $$
) &
TIMEOUT_PID=$!

# ---------------------------------------------------------------------------
# Day of week: Monday = 72h window, else 24h
# ---------------------------------------------------------------------------
DOW=$(date +%u)
if [[ "$DOW" -eq 1 ]]; then
  HOURS=72
  WINDOW_LABEL="past 3 days"
else
  HOURS=24
  WINDOW_LABEL="yesterday ($(date -v-1d '+%Y-%m-%d'))"
fi

NOW=$(date -u +%s)
WINDOW_START=$((NOW - HOURS * 3600))

log "Starting Lark Digest — $WINDOW_LABEL"

# ---------------------------------------------------------------------------
# Phase 1: Fetch all chats, then get messages for each
# ---------------------------------------------------------------------------
WORK_DIR="$LOG_DIR/.work-$$"
mkdir -p "$WORK_DIR"

log "Fetching chat list (all pages)..."

ALL_CHATS_FILE="$WORK_DIR/all_chats.tsv"
> "$ALL_CHATS_FILE"

"$LARK_CLI" im chats list --as user --page-all 2>/dev/null \
  | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    items = d.get('data', {}).get('items', [])
    for item in items:
        cid = item.get('chat_id', '')
        name = item.get('name', '').replace('\t', ' ').replace('\n', ' ')
        if cid:
            print(f'{cid}\t{name}')
except Exception as e:
    sys.stderr.write(f'ERROR parsing chats: {e}\n')
" >> "$ALL_CHATS_FILE"

TOTAL_CHATS=$(wc -l < "$ALL_CHATS_FILE" | tr -d ' ')
log "Found $TOTAL_CHATS total chats. Scanning for activity..."

ACTIVE_FILES=()

while IFS=$'\t' read -r CHAT_ID CHAT_NAME; do
  [[ -z "$CHAT_ID" ]] && continue

  MSGS=$("$LARK_CLI" api GET /open-apis/im/v1/messages \
    --params "{\"container_id\":\"${CHAT_ID}\",\"container_id_type\":\"chat\",\"page_size\":50,\"sort_type\":\"ByCreateTimeDesc\",\"start_time\":\"${WINDOW_START}\",\"end_time\":\"${NOW}\"}" \
    --as user \
    2>/dev/null || echo "")

  [[ -z "$MSGS" ]] && continue

  ENTRY=$(CHAT_NAME_ENV="$CHAT_NAME" python3 -c "
import json, sys, os, re
chat_name = os.environ.get('CHAT_NAME_ENV', '')
raw = sys.stdin.read()
raw = re.sub(r'[\x00-\x08\x0b\x0c\x0e-\x1f]', '', raw)
try:
    d = json.loads(raw)
    items = d.get('data', {}).get('items', [])
    msgs = []
    for m in items:
        content_str = m.get('body', {}).get('content', '')
        sender = m.get('sender', {}).get('sender_id', {}).get('user_id', 'unknown')
        try:
            content = json.loads(content_str)
            text = content.get('text', content_str)
        except:
            text = content_str
        text = str(text).strip()
        if text and text != '{}':
            msgs.append(f'[{sender}]: {text}')
    count = len(msgs)
    if count < 2:
        sys.exit(0)
    msgs = msgs[-30:]
    out = {'name': chat_name, 'count': count, 'messages': msgs}
    print(json.dumps(out, ensure_ascii=False))
except Exception as e:
    sys.stderr.write(f'ERROR: {e}\n')
    sys.exit(1)
" <<< "$MSGS")

  if [[ -n "$ENTRY" ]]; then
    ENTRY_FILE="$WORK_DIR/chat-${CHAT_ID}.json"
    echo "$ENTRY" > "$ENTRY_FILE"
    ACTIVE_FILES+=("$ENTRY_FILE")
    MSG_COUNT=$(echo "$ENTRY" | python3 -c "import json,sys; print(json.load(sys.stdin)['count'])" 2>/dev/null || echo "?")
    log "  $CHAT_NAME: $MSG_COUNT messages"
  fi
done < "$ALL_CHATS_FILE"

ACTIVE_COUNT=${#ACTIVE_FILES[@]}
log "Found $ACTIVE_COUNT active chats — calling Claude..."

if [[ "$ACTIVE_COUNT" -eq 0 ]]; then
  log "No active chats found. Exiting."
  kill $TIMEOUT_PID 2>/dev/null || true
  exit 0
fi

# ---------------------------------------------------------------------------
# Phase 2: Single Claude API call
# ---------------------------------------------------------------------------
CHATS_BLOCK=$(python3 -c "
import json, sys, glob, os

files = glob.glob('$WORK_DIR/chat-*.json')
chats = []
for f in files:
    try:
        d = json.loads(open(f).read())
        chats.append(d)
    except:
        pass

chats.sort(key=lambda x: x.get('count', 0), reverse=True)

parts = []
for c in chats:
    header = f\"[{c['name']}] ({c['count']} messages)\"
    body = '\n'.join(c.get('messages', []))
    parts.append(f'{header}\n{body}')

print('\n\n'.join(parts))
")

PROMPT="You are analyzing Lark group chat messages for ${DIGEST_PERSONA}.

Analyze ALL chats below and respond with valid JSON ONLY — no markdown fences, no explanation, no extra text.

For each chat, assign an urgency level:
- \"red\": Requires immediate human action or decision today
- \"yellow\": Has pending decisions or unresolved items that need attention soon
- \"green\": FYI only — already being handled or no action needed

Rules:
- summary: EXACTLY one sentence, max 25 words. No names of specific people.
- key_decisions: One sentence max. Only for red/yellow. Empty string for green.
- action_items: One sentence max, most critical action only. Only for red/yellow. Empty string for green.
- Do NOT mention specific people's names anywhere. Use impersonal language.

Required JSON format:
{
  \"chats\": [
    {
      \"name\": \"Chat Name\",
      \"count\": 41,
      \"urgency\": \"red\",
      \"summary\": \"One sentence, max 25 words.\",
      \"key_decisions\": \"One sentence or empty string.\",
      \"action_items\": \"One sentence or empty string.\"
    }
  ]
}

Include ALL chats. Sort by urgency first (red -> yellow -> green), then by message count descending within each group.

--- CHATS ---

$CHATS_BLOCK"

PAYLOAD=$(python3 -c "
import json, sys
prompt = sys.stdin.read()
payload = {
    'model': '$CLAUDE_MODEL',
    'max_tokens': 8192,
    'messages': [{'role': 'user', 'content': prompt}]
}
print(json.dumps(payload))
" <<< "$PROMPT")

call_claude() {
  curl -s \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "content-type: application/json" \
    -d "$PAYLOAD" \
    "https://api.anthropic.com/v1/messages"
}

CLAUDE_RESPONSE=$(call_claude) || {
  log "WARNING: Claude call failed, retrying in 5s..."
  sleep 5
  CLAUDE_RESPONSE=$(call_claude) || CLAUDE_RESPONSE=""
}

ANALYSIS_JSON=$(echo "$CLAUDE_RESPONSE" | python3 -c "
import json, sys
raw = sys.stdin.read()
try:
    d = json.loads(raw)
    text = d.get('content', [{}])[0].get('text', '')
    lines = text.strip().split('\n')
    if lines and lines[0].startswith('\`\`\`'):
        lines = lines[1:]
    if lines and lines[-1].strip() == '\`\`\`':
        lines = lines[:-1]
    print('\n'.join(lines).strip())
except Exception as e:
    sys.stderr.write(f'ERROR extracting Claude text: {e}\n')
    print('')
")

log "Claude responded (${#ANALYSIS_JSON} chars)"

JSON_OK=$(echo "$ANALYSIS_JSON" | python3 -c "
import json, sys
try:
    json.load(sys.stdin)
    print('yes')
except:
    print('no')
")

if [[ "$JSON_OK" != "yes" ]]; then
  log "ERROR: Claude returned invalid JSON. Sending fallback."
  "$LARK_CLI" im +messages-send \
    --user-id "$LARK_USER_ID" \
    --text "⚠️ Lark Digest failed on $(date +%Y-%m-%d): Claude returned invalid JSON. Active chats: $ACTIVE_COUNT." \
    --as bot 2>/dev/null || true
  kill $TIMEOUT_PID 2>/dev/null || true
  rm -rf "$WORK_DIR"
  exit 1
fi

# ---------------------------------------------------------------------------
# Phase 3: Build Lark Interactive Card and send
# ---------------------------------------------------------------------------
ELAPSED=$(( $(date +%s) - START_TIME ))
TODAY=$(date '+%Y-%m-%d')

CARD_JSON=$(TODAY="$TODAY" ACTIVE_COUNT="$ACTIVE_COUNT" ELAPSED="$ELAPSED" WINDOW_LABEL="$WINDOW_LABEL" \
  python3 -c "
import json, sys, os

data = json.load(sys.stdin)
today = os.environ['TODAY']
active_count = os.environ['ACTIVE_COUNT']
elapsed = os.environ['ELAPSED']
window_label = os.environ['WINDOW_LABEL']

chats = data.get('chats', [])
red_chats    = [c for c in chats if c.get('urgency') == 'red']
yellow_chats = [c for c in chats if c.get('urgency') == 'yellow']
green_chats  = [c for c in chats if c.get('urgency') == 'green']
attention_chats = red_chats + yellow_chats
attention_count = len(attention_chats)
fyi_count = len(green_chats)
urgency_emoji = {'red': '🔴', 'yellow': '🟡', 'green': '🟢'}
elements = []

def add_chat_block(chat):
    name = chat.get('name', '')
    count = chat.get('count', 0)
    urgency = chat.get('urgency', 'green')
    summary = chat.get('summary', '')
    key_decisions = chat.get('key_decisions', '').strip()
    action_items = chat.get('action_items', '').strip()
    emoji = urgency_emoji.get(urgency, '🟢')
    lines = [f'{emoji} **{name}**  ·  {count} msgs']
    lines.append(summary)
    if key_decisions:
        lines.append(f'**Key Decisions:** {key_decisions}')
    if action_items:
        lines.append(f'**Action Items:** {action_items}')
    elements.append({'tag': 'div', 'text': {'content': chr(10).join(lines), 'tag': 'lark_md'}})

if attention_chats:
    elements.append({'tag': 'div', 'text': {'content': f'⚠️ **Needs Attention  ({attention_count})**', 'tag': 'lark_md'}})
    elements.append({'tag': 'hr'})
    for chat in attention_chats:
        add_chat_block(chat)
        elements.append({'tag': 'hr'})

if green_chats:
    elements.append({'tag': 'div', 'text': {'content': f'✅ **FYI  ({fyi_count})**', 'tag': 'lark_md'}})
    elements.append({'tag': 'hr'})
    for chat in green_chats:
        add_chat_block(chat)
        elements.append({'tag': 'hr'})

elements.append({'tag': 'note', 'elements': [{'tag': 'plain_text', 'content': f'🤖 Analyzed {active_count} chats | Run time: {elapsed}s | {window_label}'}]})

card = {
    'header': {
        'template': 'blue',
        'title': {'content': f'📊 Lark Daily Digest — {today}', 'tag': 'plain_text'},
        'subtitle': {'content': f'{active_count} active chats | {window_label}', 'tag': 'plain_text'}
    },
    'elements': elements
}
print(json.dumps(card, ensure_ascii=False, separators=(',', ':')))
" <<< "$ANALYSIS_JSON")

log "Sending card..."

SEND_RESULT=$("$LARK_CLI" im +messages-send \
  --user-id "$LARK_USER_ID" \
  --content "$CARD_JSON" \
  --msg-type interactive \
  --as bot 2>&1 || echo '{"ok":false}')

SEND_OK=$(echo "$SEND_RESULT" | python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    print('yes' if d.get('ok') else 'no')
except:
    print('no')
")

if [[ "$SEND_OK" == "yes" ]]; then
  log "✅ Digest sent successfully"
else
  log "ERROR: Card send failed. Trying plain text fallback..."
  log "Send result: $SEND_RESULT"
  "$LARK_CLI" im +messages-send \
    --user-id "$LARK_USER_ID" \
    --text "📊 Lark Daily Digest — $TODAY | $ACTIVE_COUNT active chats | Card send failed, check logs." \
    --as bot 2>/dev/null || true
fi

rm -rf "$WORK_DIR"
kill $TIMEOUT_PID 2>/dev/null || true
ELAPSED_FINAL=$(( $(date +%s) - START_TIME ))
log "Done (${ELAPSED_FINAL}s)"
