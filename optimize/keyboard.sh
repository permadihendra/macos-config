#!/usr/bin/env bash
set -e

case "$1" in
  enable)
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat -int 10
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    ;;
  restore)
    defaults delete NSGlobalDomain KeyRepeat || true
    defaults delete NSGlobalDomain InitialKeyRepeat || true
    defaults delete NSGlobalDomain ApplePressAndHoldEnabled || true
    ;;
esac
