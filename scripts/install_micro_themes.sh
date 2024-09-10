#!/bin/bash
# requires sudo if necessary

# Define variables for both repositories and temporary directories
REPO_URL1="https://github.com/catppuccin/micro"
REPO_URL2="https://github.com/zyedidia/micro"
TEMP_DIR1=$(mktemp -d)
TEMP_DIR2=$(mktemp -d)
DEST_DIR="$HOME/.config/micro/colorschemes"

# Clone the first repository
git clone "$REPO_URL1" "$TEMP_DIR1" || { echo "Failed to clone $REPO_URL1"; exit 1; }

# Clone the second repository
git clone "$REPO_URL2" "$TEMP_DIR2" || { echo "Failed to clone $REPO_URL2"; exit 1; }

# Create the destination directory if it does not exist
mkdir -p "$DEST_DIR"

# Copy files from the first repository
cp -r "$TEMP_DIR1/src/." "$DEST_DIR" || { echo "Failed to copy files from $REPO_URL1"; exit 1; }

# Copy files from the second repository
cp -r "$TEMP_DIR2/runtime/colorschemes/." "$DEST_DIR" || { echo "Failed to copy files from $REPO_URL2"; exit 1; }

# Remove the temporary directories
rm -rf "$TEMP_DIR1" || { echo "Failed to remove temporary directory $TEMP_DIR1"; exit 1; }
rm -rf "$TEMP_DIR2" || { echo "Failed to remove temporary directory $TEMP_DIR2"; exit 1; }

echo "Themes installed successfully!"
