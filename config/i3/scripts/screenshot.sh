#!/bin/bash

# Define the filename with timestamp
FILENAME="$HOME/Pictures/$(date +'%Y-%m-%d_%H-%M-%S').png"

# Take a screenshot of a selected region and save it
scrot -s "$FILENAME"

# Copy the image to the clipboard
xclip -selection clipboard -t image/png -i < "$FILENAME"

# Notify the user
if [[ -f "$FILENAME" ]]; then
    notify-send "Screenshot" "Saved and copied to clipboard:\n$FILENAME"
else
    notify-send "Screenshot" "Failed to take screenshot."
fi
