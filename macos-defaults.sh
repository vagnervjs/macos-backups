#!/bin/bash

BACKUP_DIR="${2:-./macos-backup}"
MACOS_DEFAULTS_DIR="$BACKUP_DIR/macos-defaults"

function backup_defaults() {
    echo "🧪 Backing up macOS system defaults to $MACOS_DEFAULTS_DIR"
    mkdir -p "$MACOS_DEFAULTS_DIR"

    for domain in $(defaults domains | tr -d ',' | tr ' ' '\n' | grep "^com\.apple"); do
        defaults export "$domain" "$MACOS_DEFAULTS_DIR/$domain.plist" 2>/dev/null
    done

    echo "✅ macOS defaults saved."
}

function restore_defaults() {
    echo "🔁 Restoring macOS defaults from $MACOS_DEFAULTS_DIR"
    if [ ! -d "$MACOS_DEFAULTS_DIR" ]; then
        echo "❌ No defaults directory found."
        exit 1
    fi

    for plist in "$MACOS_DEFAULTS_DIR"/*.plist; do
        domain=$(basename "$plist" .plist)
        defaults import "$domain" "$plist"
    done

    echo "✅ macOS defaults restored. A logout or reboot may be needed."
}

case "$1" in
    backup)
        backup_defaults
        ;;
    restore)
        restore_defaults
        ;;
    *)
        echo "Usage: $0 {backup|restore} [backup-directory]"
        exit 1
        ;;
esac
