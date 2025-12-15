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
Below is a **clean, beginner-friendly, and well-structured README section** you can drop directly into your main repo README or into a Raycast-specific README.
Tone is explanatory, opinionated, but safe — consistent with the philosophy you’ve been following.

---

## Raycast Keyboard Shortcuts – Recommended Setup

This repository uses **Raycast** as the primary tool for window management and fast application switching.
The shortcut design prioritizes:

* Ergonomics (minimal finger travel)
* Low conflict with macOS and applications
* Consistency with visual layout (Dock)
* Easy recall for daily use

The setup is **manual, explicit, and reversible**.

---

### 1. Window Management Shortcuts

Window management uses **Control + Option** combined with **directional keys**.
This mirrors spatial movement and avoids conflicts with application shortcuts.

#### Rationale

* Arrow keys match window direction
* `⌃⌥` is rarely used by apps
* Works reliably across most applications
* Similar mental model to tiling window managers

#### Recommended Mappings

| Shortcut | Action                    |
| -------- | ------------------------- |
| `⌃⌥↑`    | Fullscreen                |
| `⌃⌥↓`    | Reasonable size / Restore |
| `⌃⌥←`    | Left half                 |
| `⌃⌥→`    | Right half                |
| `⌃⌥;`    | Top-left quarter          |
| `⌃⌥,`    | Bottom-left quarter       |
| `⌃⌥'`    | Top-right quarter         |
| `⌃⌥/`    | Bottom-right quarter      |

> These shortcuts are intended to be configured using **Raycast → Window Management** commands.

---

### 2. Dock-Ordered App Switching (Right ⌘ + ⌥ + Number)

This setup recreates a **Windows-style taskbar workflow** using Raycast, while remaining fully compatible with macOS.

#### Concept

1. Core applications are **manually ordered in the Dock**
2. Numeric shortcuts mirror this order
3. Switching becomes both **visual and muscle-memory driven**

This combines:

* Visual memory (Dock position)
* Numeric recall
* Fast keyboard access

---

#### Shortcut Pattern

```
Right ⌘ + ⌥ + Number
```

Examples:

| Shortcut | Application (example) |
| -------- | --------------------- |
| `R⌘⌥1`   | Finder                |
| `R⌘⌥2`   | Browser               |
| `R⌘⌥3`   | Telegram              |
| `R⌘⌥4`   | Terminal              |
| `R⌘⌥5`   | Code Editor           |

> Always use **Right Command**, not Left.
> Most applications bind shortcuts only to Left Command, reducing conflicts.

---

#### Important Notes

* Dock order is **manual and intentional**
* Raycast shortcuts do **not automatically follow Dock order**
* Keep the number of mapped apps small (recommended: 1–6)
* Reordering the Dock requires updating shortcuts accordingly

---

### Recommended Usage Pattern

| Task                      | Method           |
| ------------------------- | ---------------- |
| Switch between core apps  | `R⌘⌥ + Number`   |
| Switch ad-hoc apps        | Raycast search   |
| Switch windows (same app) | `⌘ + ``          |
| Move / resize windows     | `⌃⌥ + Direction` |

This avoids shortcut overload while keeping common actions fast.

---

### Design Philosophy Summary

* **Do not fight macOS defaults**
* Optimize only high-frequency actions
* Prefer clarity over cleverness
* Avoid deep system modifications
* Keep everything reversible

This Raycast configuration is designed to be **stable across macOS updates** and **portable across machines**.

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
