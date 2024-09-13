#!/bin/bash

# i3 config file path
config_file="$HOME/.config/i3/config"

# Define mod variables
mod1="Mod1"
mod4="Mod4"

# Check if the config file exists
if [ ! -f "$config_file" ]; then
    echo "Config file does not exist: $config_file"
    exit 1
fi

# Function to switch to mod4
switch_to_mod4() {
    echo "Switching to Mod4..."

    # Backup the current config file
    cp "$config_file" "$config_file.bak"

    # Replace mod1 with mod4
    sed -i \
    -e "s/floating_modifier \$mod1/floating_modifier \$mod4/g" \
    -e "s/bindsym \$mod1/bindsym \$mod4/g" \
    -e "s/bindsym \$mod1+\(.\+\) focus \(.\+\)/bindsym \$mod4+\1 focus \2/g" \
    -e "s/bindsym \$mod1+shift+\(.\+\) move \(.\+\)/bindsym \$mod4+shift+\1 move \2/g" \
    -e "s/bindsym \$mod1+shift+\(.\+\) move container to workspace number \$ws\(.\+\)/bindsym \$mod4+shift+\1 move container to workspace number \$ws\2/g" \
    -e "s/bindsym \$mod1+shift+\(.\+\) fullscreen/bindsym \$mod4+shift+\1 fullscreen/g" \
    -e "s/bindsym \$mod1+f/bindsym \$mod4+f/g" \
    -e "s/bindsym \$mod1+y/bindsym \$mod4+y/g" \
    -e "s/bindsym \$mod1+ctrl+\(.\+\) resize \(.\+\)/bindsym \$mod4+ctrl+\1 resize \2/g" \
    -e "s/bindsym \$mod1+ctrl+\(.\+\) gaps \(.\+\)/bindsym \$mod4+ctrl+\1 gaps \2/g" \
    "$config_file"
    
    echo "Switched to Mod4"
}

# Function to switch to mod1
switch_to_mod1() {
    echo "Switching to Mod1..."

    # Backup the current config file
    cp "$config_file" "$config_file.bak"

    # Replace mod4 with mod1
    sed -i \
    -e "s/floating_modifier \$mod4/floating_modifier \$mod1/g" \
    -e "s/bindsym \$mod4/bindsym \$mod1/g" \
    -e "s/bindsym \$mod4+\(.\+\) focus \(.\+\)/bindsym \$mod1+\1 focus \2/g" \
    -e "s/bindsym \$mod4+shift+\(.\+\) move \(.\+\)/bindsym \$mod1+shift+\1 move \2/g" \
    -e "s/bindsym \$mod4+shift+\(.\+\) move container to workspace number \$ws\(.\+\)/bindsym \$mod1+shift+\1 move container to workspace number \$ws\2/g" \
    -e "s/bindsym \$mod4+shift+\(.\+\) fullscreen/bindsym \$mod1+shift+\1 fullscreen/g" \
    -e "s/bindsym \$mod4+f/bindsym \$mod1+f/g" \
    -e "s/bindsym \$mod4+y/bindsym \$mod1+y/g" \
    -e "s/bindsym \$mod4+ctrl+\(.\+\) resize \(.\+\)/bindsym \$mod1+ctrl+\1 resize \2/g" \
    -e "s/bindsym \$mod4+ctrl+\(.\+\) gaps \(.\+\)/bindsym \$mod1+ctrl+\1 gaps \2/g" \
    "$config_file"
    
    echo "Switched to Mod1"
}

# Print current mod keybindings for debugging
echo "Current i3 config content before changes:"
grep 'bindsym' "$config_file"

# Check the current configuration and toggle
if grep -q "floating_modifier $mod1" "$config_file"; then
    switch_to_mod4
else
    switch_to_mod1
fi

# Reload i3 configuration
i3-msg reload
