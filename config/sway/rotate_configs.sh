#!/bin/bash

# This script copies "super_navigation.config" to sway "config" and/or "alt_navigation.config" to sway "config"
# Purpose: rotates MOD functionality. -> alt_navigation.config = mod1(alt) navigation keybinds | super_navigation.config = mod4(win/super) navigation keybinds

# Paths to the files
config=~/.config/sway/config
alt_config=~/.config/sway/alt_navigation.config
super_config=~/.config/sway/super_navigation.config

# Determine which config is currently active
if cmp -s "$config" "$super_config"; then
    echo "Switching to alt config..."
    cp "$alt_config" "$config"
else
    echo "Switching to super config..."
    cp "$super_config" "$config"
fi

# Reload the sway window manager
sway reload
