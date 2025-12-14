#!/usr/bin/env bash
set -e

case "$1" in
  enable)
    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
    defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
    defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

    echo "NOTE: Reduce Motion cannot be set via CLI on modern macOS."
    echo "Enable it manually for best results:"
    echo "System Settings → Accessibility → Display → Reduce motion"
    ;;
  restore)
    defaults delete NSGlobalDomain NSAutomaticWindowAnimationsEnabled || true
    defaults delete NSGlobalDomain NSScrollAnimationEnabled || true
    defaults delete NSGlobalDomain NSWindowResizeTime || true
    ;;
esac
