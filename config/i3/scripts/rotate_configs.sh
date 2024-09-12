#!/bin/bash

# This script copies "super_navigation.config" to i3 "config" and/or "alt_navigation.config" to i3 "config"
# Purpose: rotates MOD functionality. -> alt_navigation.config = mod1(alt) navigation keybinds | super_navigation.config = mod4(win/super) navigation keybinds

# Paths to the files
config=~/.config/i3/config
alt_config=~/.config/i3/alt_navigation.config
super_config=~/.config/i3/super_navigation.config

# Determine which config is currently active
if cmp -s "$config" "$super_config"; then
    echo "Switching to alt config..."
    cp "$alt_config" "$config"
else
    echo "Switching to super config..."
    cp "$super_config" "$config"
fi

# Reload the i3 window manager
i3 reload
