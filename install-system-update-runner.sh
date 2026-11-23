#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# APPLICATION: System Update Runner Installer
# DESCRIPTION: Downloads and installs System Update Runner.
# AUTHOR:      M. Wait
# GITHUB:      https://github.com/cybermaxpower/System-Update-Runner
# ==============================================================================

echo "Installing System Update Runner..."
echo

# GitHub download locations
RAW_BASE="https://raw.githubusercontent.com/cybermaxpower/System-Update-Runner/main"

APP_URL="$RAW_BASE/system-updater-runner"

# This matches the icon's CURRENT filename in the GitHub repository.
ICON_URL="$RAW_BASE/system-update-runnder.png"

# Installation destinations
APP_DEST="/usr/local/bin/system-updater-runner"
ICON_DEST="/usr/share/pixmaps/system-update-runner.png"
DESKTOP_DEST="/usr/share/applications/system-update-runner.desktop"

# Check required commands
for cmd in wget sudo install; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: Required command '$cmd' is not installed."
        exit 1
    fi
done

# Create temporary download directory
TMP_DIR=$(mktemp -d)
trap 'rm -rf -- "$TMP_DIR"' EXIT

APP_FILE="$TMP_DIR/system-updater-runner"
ICON_FILE="$TMP_DIR/system-update-runner.png"
DESKTOP_FILE="$TMP_DIR/system-update-runner.desktop"

# Download application
echo "Downloading System Update Runner..."

wget -O "$APP_FILE" "$APP_URL"

# Check that the downloaded file is the expected Bash script
if [[ ! -s "$APP_FILE" ]] || \
   [[ "$(head -n 1 "$APP_FILE")" != "#!/usr/bin/env bash" ]]; then
    echo "Error: The application download is missing or invalid."
    exit 1
fi

# Download application icon
echo "Downloading application icon..."

wget -O "$ICON_FILE" "$ICON_URL"

if [[ ! -s "$ICON_FILE" ]]; then
    echo "Error: The icon download failed."
    exit 1
fi

# Install application
echo "Installing application..."

sudo install -D -m 755 "$APP_FILE" "$APP_DEST"

# Install icon
echo "Installing application icon..."

sudo install -D -m 644 "$ICON_FILE" "$ICON_DEST"

# Create desktop launcher
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=System Update Runner
Comment=Update packages across multiple package managers
Exec=/usr/local/bin/system-updater-runner
Icon=/usr/share/pixmaps/system-update-runner.png
Terminal=false
Categories=System;Utility;
StartupNotify=false
EOF

# Install desktop launcher
echo "Creating application launcher..."

sudo install -D -m 644 "$DESKTOP_FILE" "$DESKTOP_DEST"

echo
echo "System Update Runner successfully installed!"
echo
echo "You can launch it from your application menu or by running:"
echo "system-updater-runner"
echo
