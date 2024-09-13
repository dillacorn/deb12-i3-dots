#!/bin/bash

# i3 config file path
config_file="$HOME/.config/i3/config"

# Function to switch to mod4
switch_to_mod4() {
    sed -i \
    -e 's/bindsym \(.*\)\($mod1\+\w\+\)/bindsym \1${mod4}\2/g' \
    -e 's/floating_modifier ${mod1}/floating_modifier ${mod4}/' \
    -e 's/bindsym ${mod1}+shift+up/bindsym ${mod4}+shift+up/g' \
    -e 's/bindsym ${mod1}+shift+Return/bindsym ${mod4}+shift+Return/g' \
    -e 's/bindsym ${mod1}+shift+c/bindsym ${mod4}+shift+c/g' \
    -e 's/bindsym ${mod1}+shift+f/bindsym ${mod4}+shift+f/g' \
    -e 's/bindsym ${mod1}+f/bindsym ${mod4}+f/g' \
    -e 's/bindsym ${mod1}+y/bindsym ${mod4}+y/g' \
    -e 's/bindsym ${mod1}+\([0-9]\)/bindsym ${mod4}+\1/g' \
    -e 's/bindsym ${mod1}+shift+\([0-9]\)/bindsym ${mod4}+shift+\1/g' \
    -e 's/bindsym ${mod1}+p exec rofi -show drun/bindsym ${mod4}+p exec rofi -show drun/g' \
    -e 's/bindsym ${mod1}+shift+p exec rofi -show run/bindsym ${mod4}+shift+p exec rofi -show run/g' \
    "$config_file"
}

# Function to switch to mod1
switch_to_mod1() {
    sed -i \
    -e 's/bindsym \(.*\)\($mod4\+\w\+\)/bindsym \1${mod1}\2/g' \
    -e 's/floating_modifier ${mod4}/floating_modifier ${mod1}/' \
    -e 's/bindsym ${mod4}+shift+up/bindsym ${mod1}+shift+up/g' \
    -e 's/bindsym ${mod4}+shift+Return/bindsym ${mod1}+shift+Return/g' \
    -e 's/bindsym ${mod4}+shift+c/bindsym ${mod1}+shift+c/g' \
    -e 's/bindsym ${mod4}+shift+f/bindsym ${mod1}+shift+f/g' \
    -e 's/bindsym ${mod4}+f/bindsym ${mod1}+f/g' \
    -e 's/bindsym ${mod4}+y/bindsym ${mod1}+y/g' \
    -e 's/bindsym ${mod4}+\([0-9]\)/bindsym ${mod1}+\1/g' \
    -e 's/bindsym ${mod4}+shift+\([0-9]\)/bindsym ${mod1}+shift+\1/g' \
    -e 's/bindsym ${mod4}+p exec rofi -show drun/bindsym ${mod1}+p exec rofi -show drun/g' \
    -e 's/bindsym ${mod4}+shift+p exec rofi -show run/bindsym ${mod1}+shift+p exec rofi -show run/g' \
    "$config_file"
}

# Check the current configuration and toggle
if grep -q "bindsym ${mod1}+p" "$config_file"; then
    switch_to_mod4
else
    switch_to_mod1
fi

# Reload i3 configuration
i3-msg reload
