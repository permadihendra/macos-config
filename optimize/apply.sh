#!/usr/bin/env bash
set -e

ACTION="$1"

if [[ "$ACTION" != "enable" && "$ACTION" != "restore" ]]; then
  echo "Usage: $0 {enable|restore}"
  exit 1
fi

echo "macOS Productivity Setup: $ACTION"
echo "--------------------------------"

for script in ui.sh keyboard.sh finder.sh dock.sh; do
  echo "==> Running $script ($ACTION)"
  bash "./$script" "$ACTION"
done

echo "Restarting UI services..."
killall Dock Finder >/dev/null 2>&1 || true

echo "Done."
