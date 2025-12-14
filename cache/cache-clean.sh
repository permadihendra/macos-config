#!/usr/bin/env bash
set -e

OS="$(uname -s)"
REPORT=()

if [[ "$OS" != "Darwin" ]]; then
  echo "This script is macOS-only."
  exit 1
fi

human_size() {
  du -sh "$1" 2>/dev/null | awk '{print $1}'
}

print_header() {
  echo
  echo "macOS Cache Cleanup"
  echo "==================="
  echo
}

status() {
  echo "Cache usage overview:"
  echo

  echo "User cache:        $(human_size "$HOME/Library/Caches")"
  echo "System cache:      $(human_size "/Library/Caches")"
  echo "Xcode cache:       $(human_size "$HOME/Library/Developer/Xcode/DerivedData")"
  echo "Homebrew cache:    $(brew --cache 2>/dev/null | xargs du -sh 2>/dev/null | awk '{print $1}')"
  echo "Trash:             $(human_size "$HOME/.Trash")"
  echo
}

clean_dir() {
  local dir="$1"
  if [[ -d "$dir" ]]; then
    rm -rf "$dir"/*
    REPORT+=("Cleaned: $dir")
  fi
}

dry_run_dir() {
  local dir="$1"
  if [[ -d "$dir" ]]; then
    echo "Would clean: $dir ($(human_size "$dir"))"
  fi
}

clean() {
  echo "Cleaning safe caches..."
  echo

  clean_dir "$HOME/Library/Caches"
  sudo clean_dir "/Library/Caches"

  clean_dir "$HOME/Library/Developer/Xcode/DerivedData"
  clean_dir "$HOME/.Trash"

  if command -v brew >/dev/null 2>&1; then
    brew cleanup -s
    REPORT+=("Homebrew cache cleaned")
  fi
}

dry_run() {
  echo "Dry run (no files deleted):"
  echo

  dry_run_dir "$HOME/Library/Caches"
  dry_run_dir "/Library/Caches"
  dry_run_dir "$HOME/Library/Developer/Xcode/DerivedData"
  dry_run_dir "$HOME/.Trash"

  if command -v brew >/dev/null 2>&1; then
    echo "Would clean: Homebrew cache"
  fi
}

print_report() {
  echo
  echo "Report"
  echo "------"
  for item in "${REPORT[@]}"; do
    echo "- $item"
  done
  echo
  echo "Note:"
  echo "Caches will be rebuilt automatically by macOS and apps."
  echo
}

print_header

case "$1" in
  status)
    status
    ;;
  clean)
    clean
    print_report
    ;;
  dry-run)
    dry_run
    ;;
  *)
    echo "Usage:"
    echo "  $0 status"
    echo "  $0 dry-run"
    echo "  $0 clean"
    exit 1
    ;;
esac
