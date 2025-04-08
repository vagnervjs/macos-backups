#!/bin/bash

BACKUP_DIR="${1:-./macos-backup}/iterm2"
mkdir -p "$BACKUP_DIR"

echo "🎨 Backing up iTerm2 settings to $BACKUP_DIR"

# Backup the iTerm2 preferences plist file
ITERM_PREFS="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
if [ -f "$ITERM_PREFS" ]; then
    cp "$ITERM_PREFS" "$BACKUP_DIR/"
    echo "✅ iTerm2 preferences backed up."
else
    echo "❌ iTerm2 preferences file not found."
fi
