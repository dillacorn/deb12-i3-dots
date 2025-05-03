#!/bin/bash

# Define output filename
FILENAME="$HOME/Pictures/$(date +'%Y-%m-%d_%H-%M-%S').png"

# Use slop to get a selection rectangle
GEOMETRY=$(slop -f "%x,%y,%w,%h") || exit 1

# Read geometry into variables
IFS=',' read -r X Y W H <<< "$GEOMETRY"

# Take a screenshot with scrot using the geometry
scrot -a "$X,$Y,$W,$H" "$FILENAME"

# Copy the image to clipboard
xclip -selection clipboard -t image/png -i < "$FILENAME"

# Notify the user
if [[ -f "$FILENAME" ]]; then
    notify-send "Screenshot" "Saved and copied: $FILENAME"
else
    notify-send "Screenshot" "Failed to capture screenshot."
fi
