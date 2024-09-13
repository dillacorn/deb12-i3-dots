#!/bin/bash

# Path to your i3 config file
CONFIG_FILE="$HOME/.config/i3/config"

# Backup the original config file before making changes
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

# Temporary file to store the updated config
TEMP_CONFIG=$(mktemp)

# Define the mod keys section start and end for exclusion
MOD_KEYS_SECTION='^# mod keys'
MOD_KEYS_START='set \$mod1 Mod1'
MOD_KEYS_END='set \$mod4 Mod4'

# Process the config file to update mod keys
while IFS= read -r line; do
    if [[ $line == $MOD_KEYS_START ]]; then
        # Print the mod keys section as is
        echo "$line" >> "$TEMP_CONFIG"
        while IFS= read -r line; do
            echo "$line" >> "$TEMP_CONFIG"
            if [[ $line == $MOD_KEYS_END ]]; then
                break
            fi
        done
    else
        # Process other lines for mod key replacements
        if grep -q 'set \$mod4' "$CONFIG_FILE"; then
            # Replace mod4 with mod1
            echo "${line//mod4/mod1}" >> "$TEMP_CONFIG"
            echo "${line//Mod4/Mod1}" >> "$TEMP_CONFIG"
        else
            # Replace mod1 with mod4
            echo "${line//mod1/mod4}" >> "$TEMP_CONFIG"
            echo "${line//Mod1/Mod4}" >> "$TEMP_CONFIG"
        fi
    fi
done < "$CONFIG_FILE"

# Overwrite the original config with the updated one
mv "$TEMP_CONFIG" "$CONFIG_FILE"

# Restart i3 to apply the changes
i3-msg restart

# Notify user
echo "Configuration updated and i3 restarted. Please check if changes took effect."
