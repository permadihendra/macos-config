# Zsh, Oh My Zsh & Powerlevel10k Setup

This directory contains a script to set up a **modern, fast, and readable Zsh environment** for CLI-focused users.

The setup is designed to be:

* Safe to run multiple times
* Minimal and predictable
* Suitable for macOS
* Largely compatible with Linux

---

## What This Setup Provides

### Automated

* Zsh detection
* Oh My Zsh installation (official installer)
* Powerlevel10k theme installation (official repository)
* Zsh configuration update to use Powerlevel10k
* Safe reconfiguration without reinstalling everything

### Manual (By Design)

* Font installation
* Terminal color theme selection
* Powerlevel10k interactive prompt tuning

These steps are intentionally manual to avoid breaking existing terminal setups.

---

## Requirements

* macOS or Linux
* Terminal access
* Zsh installed

  * macOS: usually preinstalled
  * Linux: install via your package manager

---

## Directory Structure

```
macos-config/zsh/
├── setup-zsh.sh
├── README.md
└── p10k/
    └── p10k.zsh   # optional future default config
```

---

## How to Use

### Step 1 — Open Terminal

---

### Step 2 — Navigate to This Directory

```bash
cd macos-config/apps/zsh
```

---

### Step 3 — Make Script Executable (First Time Only)

```bash
chmod +x setup-zsh.sh
```

---

### Step 4 — Install Everything

```bash
./setup-zsh.sh install
```

This will:

* Install Oh My Zsh (if missing)
* Install Powerlevel10k (if missing)
* Configure Zsh to use Powerlevel10k
* Print clear instructions for remaining manual steps

---

## Reconfigure Only (No Reinstall)

If Zsh, Oh My Zsh, and Powerlevel10k are already installed:

```bash
./setup-zsh.sh reconfigure
```

This only updates theme configuration and does **not** reinstall anything.

---

## Check Current Status

```bash
./setup-zsh.sh status
```

Shows whether:

* Zsh is available
* Oh My Zsh is installed
* Powerlevel10k is installed

---

## Manual Steps (Required)

### 1. Install Recommended Font

Powerlevel10k **requires a Nerd Font** to render icons correctly.

Recommended font:

```
MesloLGS Nerd Font
```

Download from:

```
https://github.com/ryanoasis/nerd-fonts/releases
```

After installing:

* Set your terminal font to **MesloLGS NF**
* Restart your terminal

---

### 2. Configure Powerlevel10k Prompt

On first terminal restart, Powerlevel10k will usually start its configuration wizard automatically.

If it does not, run:

```bash
p10k configure
```

This allows you to:

* Choose prompt style
* Enable Git status
* Adjust spacing and icons

---

### 3. Choose a Terminal Color Theme (Optional but Recommended)

This script **does not change terminal colors**.

For a GitHub-Dark-like experience, choose one of the following manually:

* macOS Terminal: custom GitHub Dark theme
* iTerm2: GitHub Dark preset
* Alacritty: GitHub Dark YAML
* Kitty: GitHub Dark config

Terminal theming is intentionally kept outside this script.

### Reconfigure Zsh Layout & Prompt

Reconfigure mode allows you to adjust the Zsh prompt without reinstalling anything.

Options include:
- Interactive Powerlevel10k configuration
- Compact one-line productivity preset
- Automatic backup of existing configuration

Command:

```bash
./setup-zsh.sh reconfigure
```

### Strong Recommendation (Next Step)

Next logical enhancements:
1. Add Zsh plugins (autosuggestions, syntax highlighting)
2. Add `uninstall` / `restore`
3. Add preset selector (`compact`, `verbose`, `minimal`)
4. Add Linux package manager detection

Tell me which one you want next.


---

## What This Script Will NOT Do

* It will not overwrite your `.zshrc` without backup
* It will not force a terminal emulator
* It will not install fonts silently
* It will not disable shell features
* It will not break existing setups

Everything is explicit and reversible.

---

## Linux Notes

* Zsh must be installed manually via your package manager
* Fonts are installed the same way
* Terminal theming depends on your emulator

The script avoids macOS-specific commands wherever possible.

---

## Summary

This setup provides:

* A clean, fast shell
* A modern prompt
* A stable foundation for CLI work

Manual steps are intentional to preserve safety and user control.

---

## Next Possible Enhancements

Planned or optional:

* Zsh plugins (autosuggestions, syntax highlighting)
* Default Powerlevel10k config file
* Terminal-specific theme installers
* Uninstall / restore script
