# macOS Cache Cleanup

This directory contains a **safe macOS cache cleanup script** designed to **free disk space** without breaking the system.

This script is for **maintenance**, not for performance hacks.

---

## What This Script Is For

* Freeing disk space
* Removing old and unused cache files
* Cleaning developer and package manager caches
* General system housekeeping

---

## What This Script Is NOT For

* Speeding up CPU performance
* Increasing RAM
* “Boosting” macOS
* Fixing system bugs

macOS automatically manages cache. Cleaning it is optional and should be done **only when disk space is low**.

---

## What Is Safe to Clean

The script only removes cache locations that macOS and applications are designed to rebuild automatically:

* User cache (`~/Library/Caches`)
* System cache (`/Library/Caches`)
* Xcode derived data
* Homebrew cache
* Trash contents

---

## What This Script Will NOT Touch

For safety, the script does **not** modify:

* `/System/Library`
* System databases
* Spotlight metadata
* App sandbox data
* iCloud cache
* SIP-protected files

No security features are disabled.

---

## Requirements

* macOS only
* Terminal access
* Administrator password (only for system cache cleanup)
* Optional: Homebrew

---

## Directory Structure

```
macos-config/cache/
├── cache-clean.sh
└── README.md
```

---

## How to Use

### Step 1 — Open Terminal

Press `Cmd + Space`, type **Terminal**, and open it.

---

### Step 2 — Navigate to the Script

```bash
cd macos-config/cache/
```

---

### Step 3 — Make Script Executable (First Time Only)

```bash
chmod +x cache-clean.sh
```

---

## Commands

### Check Cache Usage (Safe)

```bash
./cache-clean.sh status
```

Shows how much space is used by:

* User cache
* System cache
* Developer cache
* Trash

No files are deleted.

---

### Dry Run (Recommended First)

```bash
./cache-clean.sh dry-run
```

Shows **what would be deleted**, without deleting anything.

This is the safest way to preview changes.

---

### Clean Caches

```bash
./cache-clean.sh clean
```

This will:

* Remove safe cache files
* Empty Trash
* Clean Homebrew cache (if installed)

You may be asked for your password to clean system cache.

---

## What to Expect After Cleaning

This is normal behavior:

* First app launch may be slower
* Browsers may reload data
* Xcode will reindex projects
* macOS may recreate cache immediately

This does **not** indicate a problem.

---

## How Often Should You Run This?

Recommended:

* Only when disk space is low
* Monthly at most
* Before large system upgrades

Not recommended:

* Daily
* As a startup task
* As a performance “tweak”

---

## Is This Safe?

Yes, because:

* Only documented cache paths are touched
* No system files are removed
* macOS is designed to recreate these files
* The script can be previewed with dry-run

---

## Troubleshooting

### Script Says “macOS Only”

This script is intentionally limited to macOS for safety.

---

### Homebrew Not Found

Homebrew cleanup is skipped automatically.

---

## Summary

This script provides:

* Safe disk cleanup
* Clear visibility into cache usage
* No system hacks
* No false performance claims

Use it responsibly.

---

## Possible Future Improvements

* Per-application cache cleanup
* Linux version
* Space reclaimed report
* Scheduled reminders
