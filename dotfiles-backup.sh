#!/bin/bash

BACKUP_DIR="${1:-./macos-backup}/dotfiles"
mkdir -p "$BACKUP_DIR"

echo "📁 Backing up dotfiles to $BACKUP_DIR"

for file in "$HOME/.zshrc" "$HOME/.bash_profile" "$HOME/.gitconfig" "$HOME/.vimrc"; do
    [ -f "$file" ] && cp "$file" "$BACKUP_DIR/"
done

echo "✅ Dotfiles backed up."
