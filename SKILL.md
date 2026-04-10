---
name: lark-daily-digest
description: >
  Install and manage Lark Daily Digest — an automated system that fetches all active
  Lark group chats, triages them by urgency (🔴🟡🟢), and sends a structured
  Interactive Card to your Lark DM every morning via a macOS LaunchAgent.
  Invoke this skill whenever someone says "set up lark digest", "install lark daily digest",
  "help me automate my Lark chat summary", "lark morning report", "daily lark digest",
  or wants to run the digest manually, change the schedule, or troubleshoot it.
  Also invoke when someone says they want the same digest system a colleague uses.
---

# Lark Daily Digest — Setup Skill

This skill walks the user through the full installation of Lark Daily Digest on macOS:

1. Check prerequisites (lark-cli, Python 3, Homebrew)
2. Interview the user for their API key, role/context, and preferred schedule time
3. Find their Lark user ID automatically
4. Write all scripts to `~/lark-digest/`
5. Install a macOS LaunchAgent to run it on weekdays at their chosen time
6. Run a live test so they see it working immediately

The digest itself:
- Fetches ALL active Lark group chats from the previous day (72h window on Mondays)
- Calls Claude API once to analyze and triage every chat
- Sends a blue-header Lark Interactive Card with **⚠️ Needs Attention** and **✅ FYI** sections
- Each chat shows: urgency emoji (🔴🟡🟢), one-sentence summary, Key Decisions, Action Items (red/yellow only)

---

## Step 1 — Check Prerequisites

Run these checks and tell the user what you find:

```bash
/opt/homebrew/bin/lark-cli --version 2>/dev/null || echo "NOT_FOUND"
python3 --version 2>/dev/null || echo "NOT_FOUND"
which brew 2>/dev/null || echo "NOT_FOUND"
```

If **lark-cli is missing**, tell the user:
> "You need lark-cli first. Run: `brew install lark-cli` then `lark-cli auth login` to connect your Lark account. Come back when done."

If **lark-cli is present**, proceed to Step 2.

---

## Step 2 — Interview (ask one question at a time)

**Q1 — Anthropic API Key**
> "What's your Anthropic API key? It starts with `sk-ant-`. Find it at console.anthropic.com → API Keys."

**Q2 — Your role and company** (used to tune the Claude analysis prompt)
> "What's your role and company? This helps Claude understand what matters in your chats. Example: 'Head of Growth at Acme Corp' or 'Operations Manager at a logistics startup'."

**Q3 — Schedule time** (default: 8:45 AM)
> "What time do you want the digest delivered each weekday morning? (Default: 8:45 AM)"

Save all three answers — you'll need them in Steps 3–5.

---

## Step 3 — Find Their Lark User ID

```bash
/opt/homebrew/bin/lark-cli auth status 2>/dev/null
```

Extract the `open_id` field (format: `ou_xxxxxxxx`). This is their `LARK_USER_ID`.

If auth fails, ask them to run `lark-cli auth login` first.

---

## Step 4 — Write Files

```bash
mkdir -p ~/lark-digest/logs
```

**Write `~/lark-digest/config.sh`** with their actual values substituted:

```bash
#!/usr/bin/env bash
CLAUDE_MODEL="claude-sonnet-4-6"
ANTHROPIC_API_KEY="<their_api_key>"
LARK_USER_ID="<their_open_id>"
LOG_DIR="$HOME/lark-digest/logs"
DIGEST_PERSONA="<their role and company>"
```

**Write `~/lark-digest/lark_digest.sh`** — read the full script from `references/lark_digest.md` and write it verbatim to that path, then make it executable:

```bash
chmod +x ~/lark-digest/lark_digest.sh
```

The script reads `config.sh` for all credentials. The `DIGEST_PERSONA` variable is injected into the Claude prompt so analysis is tuned to their context.

---

## Step 5 — Install LaunchAgent

Parse their time into Hour and Minute integers (e.g., "8:45 AM" → Hour=8, Minute=45).
Get their macOS username: `whoami`

Write `~/Library/LaunchAgents/com.lark-digest.plist` with all values substituted:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key><string>com.lark-digest</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/Users/USERNAME/lark-digest/lark_digest.sh</string>
    </array>
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key><string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string>
        <key>HOME</key><string>/Users/USERNAME</string>
    </dict>
    <key>StartCalendarInterval</key>
    <array>
        <dict><key>Weekday</key><integer>1</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
        <dict><key>Weekday</key><integer>2</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
        <dict><key>Weekday</key><integer>3</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
        <dict><key>Weekday</key><integer>4</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
        <dict><key>Weekday</key><integer>5</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
    </array>
    <key>StandardOutPath</key><string>/Users/USERNAME/lark-digest/logs/cron.log</string>
    <key>StandardErrorPath</key><string>/Users/USERNAME/lark-digest/logs/cron.log</string>
    <key>RunAtLoad</key><false/>
</dict>
</plist>
```

Load it:
```bash
launchctl unload ~/Library/LaunchAgents/com.lark-digest.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.lark-digest.plist
launchctl list | grep lark-digest
```

A `-` in the first column means it's loaded and waiting. That's correct.

---

## Step 6 — Live Test

Tell the user:
> "All set! Running a live test now — this fetches your real Lark chats and sends you a card. It takes 3–5 minutes depending on how many chats you're in."

```bash
bash ~/lark-digest/lark_digest.sh
```

Show log output as it runs. On `✅ Digest sent successfully`, tell them:
> "Done! Check your Lark DMs — you should see a card from the bot. From now on it runs automatically at [time] every weekday."

If it fails, read the log and diagnose before reporting.

---

## Step 7 — Wrap Up

Show a summary:

```
✅ Lark Daily Digest installed

Schedule : Weekdays at [time]
Script   : ~/lark-digest/lark_digest.sh
Config   : ~/lark-digest/config.sh  ← edit this to change API key or time
Logs     : ~/lark-digest/logs/

To run manually : bash ~/lark-digest/lark_digest.sh
To change time  : edit the .plist Hour/Minute values, then:
                  launchctl unload ~/Library/LaunchAgents/com.lark-digest.plist
                  launchctl load   ~/Library/LaunchAgents/com.lark-digest.plist
```

---

## Troubleshooting

If the user reports the digest isn't running or something broke, check in order:

1. **LaunchAgent loaded?**
   `launchctl list | grep lark-digest`
   (Should show `-  0  com.lark-digest`. If missing, reload the plist.)

2. **lark-cli auth valid?**
   `lark-cli auth status`

3. **Recent log?**
   `tail -80 ~/lark-digest/logs/digest-$(date +%Y-%m-%d).log`

4. **Manual run to reproduce:**
   `bash ~/lark-digest/lark_digest.sh`

**Common errors:**
- `lark-cli: command not found` → PATH in plist missing `/opt/homebrew/bin`
- `open_id cross app` → wrong app token; lark-cli app must match the bot
- Card never arrives → check `LARK_USER_ID` matches `lark-cli auth status` open_id
- Script times out (15 min) → normal for 200+ chats; nothing is broken, just slow
