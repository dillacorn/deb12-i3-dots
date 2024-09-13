#!/bin/bash

# Path to your i3 config file
CONFIG_FILE="$HOME/.config/i3/config"

# Backup the original config file before making changes
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

# Temporary file to store the updated config
TEMP_CONFIG="/tmp/config.tmp"

# Define the mod keys section to exclude from replacement
MOD_KEYS_START="# mod keys"
MOD_KEYS_END="set \$mod4 Mod4"

# Function to check if mod4 is currently used
function is_mod4_in_use {
    grep -q 'set \$mod4' "$CONFIG_FILE"
}

# Process the config file
if is_mod4_in_use; then
    echo "Switching from mod4 to mod1..."
    awk -v RS='' -v FS='\n' '
    BEGIN {flag=0}
    /# mod keys/ {flag=1; print; next}
    /set \$mod4 Mod4/ {flag=0; gsub(/mod4/, "mod1"); gsub(/Mod4/, "Mod1"); print; next}
    flag {next}
    {print}
    ' "$CONFIG_FILE" > "$TEMP_CONFIG"
else
    echo "Switching from mod1 to mod4..."
    awk -v RS='' -v FS='\n' '
    BEGIN {flag=0}
    /# mod keys/ {flag=1; print; next}
    /set \$mod1 Mod1/ {flag=0; gsub(/mod1/, "mod4"); gsub(/Mod1/, "Mod4"); print; next}
    flag {next}
    {print}
    ' "$CONFIG_FILE" > "$TEMP_CONFIG"
fi

# Overwrite the original config with the updated one
mv "$TEMP_CONFIG" "$CONFIG_FILE"

# Restart i3 to apply the changes
i3-msg restart

# Notify user
echo "Configuration updated and i3 restarted. Please check if changes took effect."
