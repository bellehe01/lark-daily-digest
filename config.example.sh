#!/usr/bin/env bash
# config.example.sh — Copy this to config.sh and fill in your values.
# config.sh is gitignored — never commit it.

CLAUDE_MODEL="claude-sonnet-4-6"
ANTHROPIC_API_KEY="sk-ant-..."          # Get from console.anthropic.com
LARK_USER_ID="ou_xxxxxxxxxxxxxxxx"      # Run: lark-cli auth status
LOG_DIR="$HOME/lark-digest/logs"
DIGEST_PERSONA="Head of Growth at Acme Corp"  # Your role & company — tunes the Claude analysis
