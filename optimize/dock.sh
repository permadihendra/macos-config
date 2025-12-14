#!/usr/bin/env bash
set -e

case "$1" in
  enable)
    # Dock appearance
    defaults write com.apple.dock launchanim -bool false
    defaults write com.apple.dock autohide-time-modifier -float 0
    defaults write com.apple.dock autohide-delay -float 0

    # Minimize / restore
    defaults write com.apple.dock mineffect -string scale
    defaults write com.apple.dock minimize-to-application -bool true

    # Mission Control / Spaces (fastest allowed)
    defaults write com.apple.dock expose-animation-duration -float 0.1
    defaults write com.apple.dock workspaces-swoosh-animation-off -bool true
    ;;
  restore)
    defaults delete com.apple.dock launchanim || true
    defaults delete com.apple.dock autohide-time-modifier || true
    defaults delete com.apple.dock autohide-delay || true

    defaults delete com.apple.dock mineffect || true
    defaults delete com.apple.dock minimize-to-application || true

    defaults delete com.apple.dock expose-animation-duration || true
    defaults delete com.apple.dock workspaces-swoosh-animation-off || true
    ;;
esac
