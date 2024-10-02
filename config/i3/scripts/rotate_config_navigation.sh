#!/bin/bash

# Paths
config_file="$HOME/.config/i3/config"
backup_file="$HOME/.config/i3/config.bak"

# Backup the config if not already backed up
if [ ! -f "$backup_file" ]; then
    echo "Creating backup..."
    cp "$config_file" "$backup_file"
else
    echo "Backup already exists."
fi

# Function to switch to mod4
switch_to_mod4() {
    echo "Switching to mod4..."
    sed -i '/# font for window titles and bars/,/#end of window title bars & borders section/! {/bar {/,/}/! s/\$mod1/\$mod4/g}' "$config_file"
    i3-msg reload
    echo "Switched to mod4"
}

# Function to switch to mod1 (revert from backup)
switch_to_mod1() {
    echo "Switching to mod1..."
    cp "$backup_file" "$config_file"
    i3-msg reload
    echo "Switched to mod1"
}

# Check if mod1 is active and switch to mod4
if grep -q "\$mod1" "$config_file"; then
    echo "mod1 found in config, switching to mod4..."
    switch_to_mod4
else
    echo "mod4 found in config, switching to mod1..."
    switch_to_mod1
fi
