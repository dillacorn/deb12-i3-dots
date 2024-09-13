#!/bin/bash

# Define download URL and output file name
URL="https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1719425723/Anya-cursor.zip?response-content-disposition=attachment%3B%2520Anya-cursor.zip&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20240913%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240913T172838Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=422c8781ad582aa82769a9176d8313e830540cd696993615ff14dd9f1207df27"
OUTPUT_FILE="Anya-cursor.zip"
CURSOR_THEME_DIR="$HOME/.icons/Anya-cursor"

# Download the zip file using wget
echo "Downloading cursor theme..."
wget -O "$OUTPUT_FILE" "$URL"

# Create cursor theme directory if it doesn't exist
echo "Creating cursor theme directory..."
mkdir -p "$CURSOR_THEME_DIR"

# Unzip the downloaded file into the cursor theme directory
echo "Extracting the cursor theme..."
unzip "$OUTPUT_FILE" -d "$CURSOR_THEME_DIR"

# Optional: Remove the zip file after extraction
rm "$OUTPUT_FILE"

# Set the custom cursor theme for X11
echo "Setting the custom cursor theme..."
gsettings set org.gnome.desktop.interface cursor-theme 'Anya-cursor'

# Refresh X11 cursor (log out/in may be required on some systems)
echo "Cursor theme installed. You may need to log out and log back in for changes to take effect."
