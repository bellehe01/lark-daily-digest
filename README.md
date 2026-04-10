# 📊 Lark Daily Digest

An automated morning briefing for Lark (LarkSuite/Feishu) power users. Every weekday, it fetches all your active group chats, runs them through Claude AI for urgency triage, and sends you a structured Interactive Card in your Lark DMs.

![Card preview showing ⚠️ Needs Attention and ✅ FYI sections with color-coded urgency emojis](./assets/card-preview.png)

---

## What it does

- **Scans all your Lark group chats** for activity in the past 24 hours (72 hours on Mondays)
- **Triages every chat** using Claude AI into three urgency levels:
  - 🔴 **Red** — requires immediate action or decision today
  - 🟡 **Yellow** — pending items that need attention soon
  - 🟢 **Green** — FYI, already being handled
- **Sends a single Interactive Card** to your Lark DM, organized into **⚠️ Needs Attention** and **✅ FYI** sections
- Each chat entry shows: urgency emoji, one-sentence summary, Key Decisions, and Action Items (red/yellow only)
- **Runs automatically** on weekdays via macOS LaunchAgent — no manual trigger needed

---

## How it works

```
LaunchAgent (cron)
    │
    ▼
lark_digest.sh
    │
    ├── Phase 1: lark-cli → fetch all chat IDs + messages
    │
    ├── Phase 2: Claude API → one call analyzes ALL chats → structured JSON
    │
    └── Phase 3: Build Lark Interactive Card → send via lark-cli
```

One Claude API call per run, regardless of how many chats you're in. Typically completes in 3–5 minutes for 40+ active chats.

---

## Prerequisites

| Tool | Install |
|------|---------|
| [lark-cli](https://github.com/larksuite/lark-cli) | `brew install lark-cli` |
| Python 3 | `brew install python` |
| Anthropic API key | [console.anthropic.com](https://console.anthropic.com) |
| macOS | LaunchAgent scheduling (macOS only) |

---

## Setup

### 1. Clone and configure

```bash
git clone https://github.com/bellehe01/lark-daily-digest.git ~/lark-digest
cd ~/lark-digest
cp config.example.sh config.sh
```

Edit `config.sh` with your values:

```bash
CLAUDE_MODEL="claude-sonnet-4-6"
ANTHROPIC_API_KEY="sk-ant-..."        # Your Anthropic API key
LARK_USER_ID="ou_xxxxxxxxxxxxxxxx"    # Run: lark-cli auth status
DIGEST_PERSONA="Head of Growth at Acme Corp"  # Your role — tunes the AI analysis
```

To find your `LARK_USER_ID`:
```bash
lark-cli auth status   # Look for the open_id field (format: ou_...)
```

### 2. Make the script executable

```bash
chmod +x ~/lark-digest/lark_digest.sh
```

### 3. Run a live test

```bash
bash ~/lark-digest/lark_digest.sh
```

This fetches your real Lark chats and sends you a card. Takes 3–5 minutes depending on how many chats you're in. Check your Lark DMs when it finishes.

### 4. Install the LaunchAgent (automatic daily runs)

Create `~/Library/LaunchAgents/com.lark-digest.plist` — replace `YOUR_USERNAME`, `HOUR`, and `MINUTE` with your values:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key><string>com.lark-digest</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/Users/YOUR_USERNAME/lark-digest/lark_digest.sh</string>
    </array>
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key><string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string>
        <key>HOME</key><string>/Users/YOUR_USERNAME</string>
    </dict>
    <key>StartCalendarInterval</key>
    <array>
        <dict><key>Weekday</key><integer>1</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
        <dict><key>Weekday</key><integer>2</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
        <dict><key>Weekday</key><integer>3</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
        <dict><key>Weekday</key><integer>4</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
        <dict><key>Weekday</key><integer>5</integer><key>Hour</key><integer>HOUR</integer><key>Minute</key><integer>MINUTE</integer></dict>
    </array>
    <key>StandardOutPath</key><string>/Users/YOUR_USERNAME/lark-digest/logs/cron.log</string>
    <key>StandardErrorPath</key><string>/Users/YOUR_USERNAME/lark-digest/logs/cron.log</string>
    <key>RunAtLoad</key><false/>
</dict>
</plist>
```

Load it:
```bash
launchctl load ~/Library/LaunchAgents/com.lark-digest.plist
launchctl list | grep lark-digest   # Should show: -  0  com.lark-digest
```

---

## Card format

```
📊 Lark Daily Digest — 2026-04-10
42 active chats | yesterday (2026-04-09)

⚠️ Needs Attention  (5)
─────────────────────────────────────
🔴 Project Launch Chat  ·  41 msgs
Client approval is pending and the team needs a go/no-go decision before EOD.
Key Decisions: Whether to proceed with the revised timeline or push to next week.
Action Items: Confirm client decision and update the project tracker by noon.

🟡 Operations Sync  ·  18 msgs
Inventory discrepancy flagged in yesterday's warehouse report needs verification.
Key Decisions: Which SKUs to prioritize for the recount.
Action Items: Assign someone to run a spot check on the flagged items.

✅ FYI  (37)
─────────────────────────────────────
🟢 Team Social Planning  ·  12 msgs
The team is coordinating logistics for next month's offsite, no action needed.

🤖 Analyzed 42 chats | Run time: 187s | yesterday (2026-04-09)
```

---

## Troubleshooting

**Digest isn't running automatically**
```bash
launchctl list | grep lark-digest   # Should show: -  0  com.lark-digest
# If missing:
launchctl unload ~/Library/LaunchAgents/com.lark-digest.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.lark-digest.plist
```

**lark-cli: command not found**
The PATH in the plist must include `/opt/homebrew/bin`. Check the `EnvironmentVariables` section.

**No card received / auth error**
```bash
lark-cli auth status   # Verify you're logged in and open_id matches LARK_USER_ID in config.sh
```

**Check recent logs**
```bash
tail -80 ~/lark-digest/logs/digest-$(date +%Y-%m-%d).log
```

**Run manually to reproduce an error**
```bash
bash ~/lark-digest/lark_digest.sh
```

**Script times out (>15 min)**
Normal for 200+ chats — the timeout guard will notify you via Lark. Nothing is broken; subsequent runs will complete fine.

---

## Files

```
lark-digest/
├── lark_digest.sh       # Main script
├── config.sh            # Your credentials (gitignored)
├── config.example.sh    # Template — copy to config.sh
└── logs/                # Daily logs (gitignored)
    ├── digest-YYYY-MM-DD.log
    └── cron.log
```

---

## Claude Skill

This project ships as a [Claude Code](https://claude.ai/code) skill — colleagues can install the full system in minutes with an interactive setup wizard. See [SKILL.md](./SKILL.md) for details.

---

## License

MIT
