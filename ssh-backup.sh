#!/bin/bash

BACKUP_DIR="${1:-./macos-backup}/ssh-keys"
mkdir -p "$BACKUP_DIR"

echo "🔐 Backing up SSH keys (will skip if not found)..."

for file in "$HOME/.ssh/id_rsa" "$HOME/.ssh/id_ed25519"; do
    if [ -f "$file" ]; then
        cp "$file" "$BACKUP_DIR/"
        cp "$file.pub" "$BACKUP_DIR/"
    fi
done

chmod 600 "$BACKUP_DIR"/* 2>/dev/null

echo "✅ SSH keys backed up to $BACKUP_DIR (make sure to secure this folder!)"
