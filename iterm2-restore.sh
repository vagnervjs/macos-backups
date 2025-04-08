#!/bin/bash

BACKUP_DIR="${1:-./macos-backup}/iterm2"

echo "🔄 Restoring iTerm2 settings from $BACKUP_DIR"

# Restore the iTerm2 preferences plist file
ITERM_PREFS="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
BACKUP_PREFS="$BACKUP_DIR/com.googlecode.iterm2.plist"

if [ -f "$BACKUP_PREFS" ]; then
    cp "$BACKUP_PREFS" "$ITERM_PREFS"
    echo "✅ iTerm2 preferences restored."
else
    echo "❌ No iTerm2 backup found at $BACKUP_PREFS."
fi
