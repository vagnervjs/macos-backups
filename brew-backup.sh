#!/bin/bash

BACKUP_DIR="${2:-./macos-backup}"

FORMULAE_FILE="$BACKUP_DIR/brew-formulae.txt"
CASKS_FILE="$BACKUP_DIR/brew-casks.txt"
MAS_FILE="$BACKUP_DIR/mac-app-store-apps.txt"
BREWFILE="$BACKUP_DIR/Brewfile"

function backup_brew() {
    mkdir -p "$BACKUP_DIR"

    echo "📦 Backing up Homebrew formulae..."
    brew list --formula > "$FORMULAE_FILE"

    echo "📦 Backing up Homebrew casks..."
    brew list --cask > "$CASKS_FILE"

    if command -v mas &> /dev/null; then
        echo "🛍️  Backing up Mac App Store apps..."
        mas list > "$MAS_FILE"
    fi

    echo "📜 Creating Brewfile..."
    brew bundle dump --file="$BREWFILE" --force

    echo "✅ Homebrew + MAS backup complete in $BACKUP_DIR"
}

function restore_brew() {
    echo "🔁 Restoring from $BACKUP_DIR"

    if [ -f "$BREWFILE" ]; then
        brew bundle --file="$BREWFILE"
    fi

    [ -f "$FORMULAE_FILE" ] && xargs brew install < "$FORMULAE_FILE"
    [ -f "$CASKS_FILE" ] && xargs brew install --cask < "$CASKS_FILE"

    if [ -f "$MAS_FILE" ] && command -v mas &> /dev/null; then
        while read -r line; do
            app_id=$(echo "$line" | awk '{print $1}')
            mas install "$app_id"
        done < "$MAS_FILE"
    fi

    echo "✅ Homebrew + MAS restore complete"
}

case "$1" in
    backup)
        backup_brew
        ;;
    restore)
        restore_brew
        ;;
    *)
        echo "Usage: $0 {backup|restore} [backup-directory]"
        exit 1
        ;;
esac
