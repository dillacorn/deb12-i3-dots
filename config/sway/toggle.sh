#!/bin/bash

# This config copies "win.config" to "config" and/or "default.config" to "config".
# Purpose: toggle MOD functionality. -> only MOD4 or a mix of MOD4+MOD1 (WIN is MOD4 & ALT is MOD1)

# Paths to the files
config=~/.config/sway/config
default_config=~/.config/sway/default.config
win_config=~/.config/sway/win.config

# Determine which config is currently active
if cmp -s "$config" "$win_config"; then
    echo "Switching to default config..."
    cp "$default_config" "$config"
else
    echo "Switching to windowed config..."
    cp "$win_config" "$config"
fi

# Reload the sway window manager
sway reload
