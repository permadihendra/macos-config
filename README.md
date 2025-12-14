# `macos-config` — Personal macOS Configuration

A structured repository for managing **macOS configuration, productivity optimizations, and workflow setup**.

This repo is designed to be:

* Safe
* Reversible
* Modular
* Easy to expand over time

---

## Repository Structure

```
macos-config/
├── optimize/        # System-level productivity & performance tweaks
├── apps/            # (Future) App installation & configuration
├── dotfiles/        # (Future) Shell, editor, and tool configs
├── scripts/         # (Future) General-purpose utilities
└── README.md        # This file
```

Each directory is **self-contained** and has its own documentation.

---

## Optimization Scripts (`optimize/`)

The `optimize` directory contains **safe macOS tuning scripts** focused on:

* Reducing UI and window animations
* Improving keyboard responsiveness
* Making Finder and Dock more predictable
* Speeding up desktop switching (within macOS limits)

These scripts **do not**:

* Modify system files
* Disable security features
* Require SIP changes
* Install background services

### How to Use

```bash
cd optimize
chmod +x *.sh
./check.sh
./apply.sh enable
```

To restore macOS defaults:

```bash
./apply.sh restore
```

See `optimize/README.md` for full details.

---

## Design Philosophy

* **Explicit over implicit**
* **Reversible over permanent**
* **Keyboard-first**
* **No hacks**
* **No magic**

Everything should be understandable by someone reading it for the first time.

---

## Safety First

This repository intentionally avoids:

* Private macOS APIs
* Binary patching
* SIP modifications
* Accessibility permission abuse

If something requires unsafe behavior, it does **not belong here**.

---

## Who This Is For

* Developers
* Data analysts
* Terminal users
* Linux users transitioning to macOS
* Anyone who wants macOS to feel fast and predictable

---


## License

Personal configuration.
Use, adapt, and learn responsibly.

---
