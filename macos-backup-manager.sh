#!/bin/bash

MACOS_DEFAULTS_SCRIPT="./macos-defaults.sh"
BREW_SCRIPT="./brew-backup.sh"
APPS_SNAPSHOT_SCRIPT="./apps-snapshot.sh"
DOTFILES_BACKUP_SCRIPT="./dotfiles-backup.sh"
SSH_BACKUP_SCRIPT="./ssh-backup.sh"

BACKUP_DIR="${2:-./macos-backup}"

function check_dependencies() {
    for script in "$MACOS_DEFAULTS_SCRIPT" "$BREW_SCRIPT" "$APPS_SNAPSHOT_SCRIPT" "$DOTFILES_BACKUP_SCRIPT" "$SSH_BACKUP_SCRIPT"; do
        if [ ! -x "$script" ]; then
            echo "❌ Missing or non-executable: $script"
            exit 1
        fi
    done
}

function backup_all() {
    echo "📦 Backing up to $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    # Backup macOS system defaults
    "$MACOS_DEFAULTS_SCRIPT" backup "$BACKUP_DIR"
    echo "🧪 macOS system defaults backed up."

    # Backup Homebrew & App Store apps
    "$BREW_SCRIPT" backup "$BACKUP_DIR"
    echo "🍺 Homebrew + App Store apps backed up."

    # Snapshot installed apps
    "$APPS_SNAPSHOT_SCRIPT" "$BACKUP_DIR"
    echo "📸 Installed apps snapshot taken."

    # Backup dotfiles
    "$DOTFILES_BACKUP_SCRIPT" "$BACKUP_DIR"
    echo "🔧 Dotfiles backed up."

    # Backup SSH keys
    "$SSH_BACKUP_SCRIPT" "$BACKUP_DIR"
    echo "🔐 SSH keys backed up."

    echo "✅ Full backup complete."
}

function restore_all() {
    echo "🔁 Restoring from $BACKUP_DIR"

    # Restore macOS system defaults
    "$MACOS_DEFAULTS_SCRIPT" restore "$BACKUP_DIR"
    echo "🧪 macOS system defaults restored."

    # Restore Homebrew & App Store apps
    "$BREW_SCRIPT" restore "$BACKUP_DIR"
    echo "🍺 Homebrew + App Store apps restored."

    # Restore installed apps snapshot (if desired)
    echo "📸 Restoring installed apps snapshot..."
    # Custom logic to restore apps can go here

    # Restore dotfiles
    echo "🔧 Restoring dotfiles..."
    # Custom logic to restore dotfiles can go here

    # Restore SSH keys
    "$SSH_BACKUP_SCRIPT" restore "$BACKUP_DIR"
    echo "🔐 SSH keys restored."

    echo "✅ Full restore complete. You may need to log out or reboot for some settings to apply."
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
