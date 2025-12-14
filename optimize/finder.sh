#!/usr/bin/env bash
set -e

case "$1" in
  enable)
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write com.apple.finder DisableAllAnimations -bool true
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    ;;
  restore)
    defaults delete NSGlobalDomain AppleShowAllExtensions || true
    defaults delete com.apple.finder DisableAllAnimations || true
    defaults delete com.apple.finder ShowPathbar || true
    defaults delete com.apple.finder ShowStatusBar || true
    ;;
esac
