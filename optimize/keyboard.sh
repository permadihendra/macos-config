#!/usr/bin/env bash
set -e

case "$1" in
  enable)
    # Slightliy faster than default (~30%)
    defaults write NSGlobalDomain KeyRepeat -int 5
    defaults write NSGlobalDomain InitialKeyRepeat -int 16
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    ;;
  restore)
    defaults delete NSGlobalDomain KeyRepeat || true
    defaults delete NSGlobalDomain InitialKeyRepeat || true
    defaults delete NSGlobalDomain ApplePressAndHoldEnabled || true
    ;;
esac
