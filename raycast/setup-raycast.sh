#!/usr/bin/env bash
set -e

### CONFIG ###
RAYCAST_CONFIG_FILE="$HOME/raycast-config.rayconfig"
################

report=()

print_header() {
  echo
  echo "Raycast Setup Script"
  echo "===================="
  echo
}

check_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is NOT installed."
    echo "Install it from:"
    echo "https://brew.sh"
    exit 1
  fi
}

is_raycast_installed() {
  [[ -d "/Applications/Raycast.app" ]] && return 0

  mdls -name kMDItemCFBundleIdentifier /Applications/Raycast.app 2>/dev/null \
    | grep -q "com.raycast.macos"
}

raycast_install_source() {
  if brew list --cask raycast >/dev/null 2>&1; then
    echo "homebrew"
  elif [[ -d "/Applications/Raycast.app" ]]; then
    echo "dmg/manual"
  else
    echo "none"
  fi
}

disable_spotlight() {
  echo "Disabling Spotlight..."

  sudo mdutil -a -i off >/dev/null
  sudo mdutil -a -E >/dev/null
  report+=("Spotlight indexing: disabled")

  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '
  <dict>
    <key>enabled</key><false/>
  </dict>'
  report+=("Spotlight shortcut (Cmd+Space): disabled")

  killall SystemUIServer >/dev/null 2>&1 || true
}

restore_spotlight() {
  echo "Restoring Spotlight..."

  sudo mdutil -a -i on >/dev/null
  report+=("Spotlight indexing: enabled")

  defaults delete com.apple.symbolichotkeys AppleSymbolicHotKeys 2>/dev/null || true
  report+=("Spotlight shortcut: restored")

  killall SystemUIServer >/dev/null 2>&1 || true
}

import_raycast_config() {
  if [[ -f "$RAYCAST_CONFIG_FILE" ]]; then
    echo "Launching Raycast..."
    open -a Raycast

    sleep 2

    echo "Opening Raycast import settings..."
    open "raycast://settings/import"

    report+=("Raycast config: import screen opened")
    report+=("User action required: select raycast-config.rayconfig")
  else
    report+=("Raycast config: not found, skipped. Try import manually Racast -> Advance -> Import config AdGUI")
  fi
}


install_raycast() {
  local source
  source="$(raycast_install_source)"

  if [[ "$source" == "none" ]]; then
    check_brew
    echo "Installing Raycast via Homebrew..."
    brew install --cask raycast
    report+=("Raycast: installed via Homebrew")
  else
    report+=("Raycast: already installed ($source)")
  fi

  echo
  read -r -p "Do you want to replace Spotlight with Raycast? (yes/no): " answer

  if [[ "$answer" == "yes" ]]; then
    disable_spotlight
    import_raycast_config
    report+=("Raycast config: imported")
    else
        report+=("Spotlight: unchanged")
    fi
}

uninstall_raycast() {
  local source
  source="$(raycast_install_source)"

  case "$source" in
    homebrew)
      check_brew
      echo "Uninstalling Raycast (Homebrew)..."
      brew uninstall --cask raycast
      report+=("Raycast: uninstalled (Homebrew)")
      ;;
    dmg/manual)
      echo "Removing /Applications/Raycast.app..."
      rm -rf /Applications/Raycast.app
      report+=("Raycast: removed (DMG/manual)")
      ;;
    none)
      report+=("Raycast: not installed")
      ;;
  esac
}

print_report() {
  echo
  echo "Report"
  echo "------"
  for item in "${report[@]}"; do
    echo "- $item"
  done
  echo
  echo "Done."
}

### ENTRY POINT ###

print_header

case "$1" in
  install)
    install_raycast
    ;;
  uninstall)
    uninstall_raycast
    ;;
  restore-spotlight)
    restore_spotlight
    ;;
  *)
    echo "Usage:"
    echo "  $0 install"
    echo "  $0 uninstall"
    echo "  $0 restore-spotlight"
    exit 1
    ;;
esac

print_report
