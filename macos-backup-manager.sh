#!/bin/bash

MACOS_DEFAULTS_SCRIPT="./macos-defaults.sh"
BREW_SCRIPT="./brew-backup.sh"

BACKUP_DIR="${2:-./macos-backup}"

function check_dependencies() {
    for script in "$MACOS_DEFAULTS_SCRIPT" "$BREW_SCRIPT"; do
        if [ ! -x "$script" ]; then
            echo "❌ Missing or non-executable: $script"
            exit 1
        fi
    done
}

function backup_all() {
    echo "📦 Backing up to $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    "$MACOS_DEFAULTS_SCRIPT" backup "$BACKUP_DIR"
    "$BREW_SCRIPT" backup "$BACKUP_DIR"

    echo "✅ Backup complete: $BACKUP_DIR"
}

function restore_all() {
    echo "🔁 Restoring from $BACKUP_DIR"

    "$MACOS_DEFAULTS_SCRIPT" restore "$BACKUP_DIR"
    "$BREW_SCRIPT" restore "$BACKUP_DIR"

    echo "✅ Restore complete from $BACKUP_DIR"
}

case "$1" in
    backup)
        check_dependencies
        backup_all
        ;;
    restore)
        check_dependencies
        restore_all
        ;;
    *)
        echo "Usage: $0 {backup|restore} [backup-directory]"
        exit 1
        ;;
esac
