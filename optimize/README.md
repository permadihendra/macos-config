# macOS Productivity Setup (Safe & Reversible)

This repository contains a **safe, reversible, and beginner-friendly**
set of scripts to make macOS **faster, more responsive, and more predictable**
for productivity work.

No hacks. No SIP changes. No system files touched.

---

## What This Does

When enabled, this setup:

- Reduces UI and window animations
- Makes keyboard input faster and more responsive
- Removes unnecessary Finder animations
- Speeds up Dock, minimize, and desktop switching (as much as macOS allows)
- Improves overall “snappiness”

When restored, macOS returns to **Apple’s default behavior**.

---

## Requirements

- macOS Ventura / Sonoma / newer
- Terminal access
- No administrator privileges required

---

## How to Use

### 1. Make scripts executable

```bash
chmod +x *.sh
```

### 2. Check system status (recommended)
```bash
./check.sh
```
### 3. Enable productivity mode
```bash
./apply.sh enable
```

### 4. Restore macOS defaults
```bash
./apply.sh restore
```

### Important Note About Animations

macOS does not allow fully disabling desktop (Spaces) animations.
This is an Apple limitation.

For best results, also enable manually:
```sh
System Settings → Accessibility → Display → Reduce motion
```
This cannot be automated safely on modern macOS.

### What This Does NOT Do
- Does NOT modify system files
- Does NOT disable security features
- Does NOT install background services
- Does NOT break updates
- Does NOT require reboot

### Who This Is For
- Developers
- Data analysts
- Terminal users
- Keyboard-driven workflows
- Users who value speed over visual effects

### Known Limitations
- Desktop switching is faster, but not instant
- Some animations are enforced by macOS and cannot be removed
- This is the maximum optimization possible using supported methods
