# Raycast Setup Script

This script helps you **install, configure, and optionally replace Spotlight with Raycast** in a **safe and reversible way**.

It works whether Raycast was installed:

* via **DMG**
* via **Homebrew**
* manually copied into `/Applications`

No prior macOS scripting knowledge is required.

---

## What This Script Can Do

### Install Mode

* Detects whether Raycast is already installed
* Installs Raycast via Homebrew **only if missing**
* Optionally disables Spotlight and its shortcuts
* Optionally imports a Raycast configuration file
* Prints a clear report of actions taken

### Uninstall Mode

* Removes Raycast safely
* Works for both Homebrew and DMG installs
* Does **not** touch other applications

### Restore Spotlight

* Re-enables Spotlight indexing
* Restores Spotlight keyboard shortcuts
* Safe to run even if Spotlight is already enabled

---

## What This Script Will NOT Do

* It will **not** modify system files
* It will **not** disable SIP
* It will **not** remove macOS security features
* It will **not** run anything silently
* It will **not** delete Spotlight data unless you confirm replacement

Everything is explicit and reversible.

---

## Requirements

* macOS
* Terminal access
* Admin password (only when disabling Spotlight indexing)
* Optional: Homebrew

If Homebrew is missing, the script will **stop and show the official install link**.

---

## File Layout

```
macos-config/raycast/
├── setup-raycast.sh
├── README.md
└── raycast-config.rayconfig   # optional
```

---

## How to Use

### Step 1 — Open Terminal

Press `Cmd + Space`, type **Terminal**, and open it.

---

### Step 2 — Go to the Raycast Script Directory

```bash
cd macos-config/apps/raycast
```

---

### Step 3 — Make the Script Executable (First Time Only)

```bash
chmod +x setup-raycast.sh
```

---

## Install Raycast

```bash
./setup-raycast.sh install
```

What happens:

* Raycast is detected or installed
* You are asked:

  > “Do you want to replace Spotlight with Raycast?”
* Nothing is disabled unless you type **yes**

---

## Uninstall Raycast

```bash
./setup-raycast.sh uninstall
```

What happens:

* Raycast is removed safely
* Installation source is respected (Homebrew or DMG)
* Spotlight is **not** automatically restored

---

## Restore Spotlight (Recommended After Uninstall)

```bash
./setup-raycast.sh restore-spotlight
```

This:

* Re-enables Spotlight indexing
* Restores `Cmd + Space`
* Is safe to run multiple times

---

## Importing Raycast Configuration

If you place a config file here:

```
raycast-config.rayconfig
```

The script will:

* Open it automatically
* Let Raycast import it normally
* Never overwrite your settings silently

If the file is missing, the script continues safely.

---

## Common Questions

### Is Spotlight permanently disabled?

No. It can be restored at any time using:

```bash
./setup-raycast.sh restore-spotlight
```

---

### What if I answer “no” to replacing Spotlight?

Nothing changes. Raycast is installed only.

---

### What if Raycast was installed manually?

The script detects it and **does not reinstall**.

---

### Can this break macOS?

No. Only documented system commands are used.

---

## Troubleshooting

### Homebrew Not Installed

The script will show:

```
https://brew.sh
```

Install Homebrew and run again.

---

### Password Prompt

This is required only to enable or disable Spotlight indexing.
It is a macOS requirement.
