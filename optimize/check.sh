#!/usr/bin/env bash
set -e

echo "macOS Productivity Setup — System Check"
echo "---------------------------------------"

OS_VERSION=$(sw_vers -productVersion)
echo "macOS version: $OS_VERSION"

echo
echo "Checking Reduce Motion (Accessibility)..."

if defaults read com.apple.universalaccess reduceMotion >/dev/null 2>&1; then
  VALUE=$(defaults read com.apple.universalaccess reduceMotion)
  if [[ "$VALUE" == "1" ]]; then
    echo "✔ Reduce Motion: ENABLED"
  else
    echo "✘ Reduce Motion: DISABLED"
  fi
else
  echo "⚠ Reduce Motion status cannot be read via CLI"
  echo "  Please check manually:"
  echo "  System Settings → Accessibility → Display → Reduce motion"
fi

echo
echo "This setup only modifies:"
echo "- Global UI preferences"
echo "- Dock behavior"
echo "- Finder behavior"
echo "- Keyboard repeat settings"

echo
echo "No system files, daemons, or security settings are modified."
