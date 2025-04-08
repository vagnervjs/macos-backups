#!/bin/bash

BACKUP_DIR="${1:-./macos-backup}/system-info"
mkdir -p "$BACKUP_DIR"

ls /Applications > "$BACKUP_DIR/installed-apps.txt"
system_profiler SPApplicationsDataType > "$BACKUP_DIR/system-app-details.txt"

echo "📸 Saved installed apps list to $BACKUP_DIR"
