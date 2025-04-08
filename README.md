# macOS Backup Scripts

This repository contains simple scripts to help you back up and restore key macOS settings and tools before formatting or reinstalling your Mac.

## How to use

### 📦 Backup

```bash
./macos-backup-manager.sh backup ~/my-mac-backup
```

### 🔁 Restore

```bash
./macos-backup-manager.sh restore ~/my-mac-backup
```

---

## 📁 Included Scripts

- `macos-defaults.sh` – Backup and restore **macOS system preferences** using the `defaults` command.
- `brew-backup.sh` – Backup and restore **Homebrew packages** and **Mac App Store apps**.

---

## 🔧 `macos-defaults.sh`

### ✅ What it does
- Exports macOS system settings (e.g., Finder, Dock, screenshots, etc.) for all `com.apple.*` domains.
- Allows you to restore them after reinstalling macOS.

### 📦 Backup Usage
```bash
./macos-defaults.sh backup
```

This creates a folder named macos-defaults-backup with individual .plist files for each Apple domain.

### 🔁 Restore Usage

```bash
./macos-defaults.sh restore
```

Restores all previously exported settings. You may need to log out and back in to apply all changes.

---

## 🍺 `brew-backup.sh`

### ✅ What it does
- Saves a list of all installed Homebrew packages
- Saves a list of installed Mac App Store apps (using mas)

### 📦 Backup Usage

```bash
./brew-backup.sh backup
```

Generates:
- brew-formulae.txt – List of CLI tools
- brew-casks.txt – List of GUI apps (e.g., Chrome, VSCode)
- mac-app-store-apps.txt – MAS apps with IDs
- Brewfile – One-stop manifest for all Homebrew-managed installs

### 🔁 Restore Usage

```bash
./brew-backup.sh restore
```

Reinstalls:
- All packages from brew-packages.txt
- All MAS apps (you must be logged into the App Store)

### ℹ️ Make sure brew and mas are installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install mas
```



