#!/bin/bash

# Path to your i3 config file
CONFIG_FILE="$HOME/.config/i3/config"

# Backup the original config file before making changes
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

# Define the mod keys section to exclude from replacement
MOD_KEYS_START="# mod keys"
MOD_KEYS_END="set \$mod4 Mod4"

# Temporary files to store parts of the config
TEMP_CONFIG="/tmp/config.tmp"
TEMP_KEYS="/tmp/keys.tmp"

# Extract the mod keys section
awk "/$MOD_KEYS_START/,/$MOD_KEYS_END/ {print}" "$CONFIG_FILE" > "$TEMP_KEYS"
# Extract the rest of the config
awk "!/$MOD_KEYS_START/ && !/$MOD_KEYS_END/" "$CONFIG_FILE" > "$TEMP_CONFIG"

# Function to check if mod4 is currently used
function is_mod4_in_use {
    grep -q 'set \$mod4' "$CONFIG_FILE"
}

# Check if the config uses mod4 and perform the replacement
if is_mod4_in_use; then
    echo "Switching from mod4 to mod1..."
    sed -i 's/mod4/mod1/g' "$TEMP_CONFIG"
    sed -i 's/Mod4/Mod1/g' "$TEMP_KEYS"
else
    echo "Switching from mod1 to mod4..."
    sed -i 's/mod1/mod4/g' "$TEMP_CONFIG"
    sed -i 's/Mod1/Mod4/g' "$TEMP_KEYS"
fi

# Reassemble the config file
cat "$TEMP_KEYS" "$TEMP_CONFIG" > "$CONFIG_FILE"

# Clean up temporary files
rm "$TEMP_CONFIG" "$TEMP_KEYS"

# Restart i3 to apply the changes
i3-msg restart

# Notify user
echo "Configuration updated and i3 restarted. Please check if changes took effect."
