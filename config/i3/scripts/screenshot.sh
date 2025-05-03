#!/bin/bash

# Capture screenshot with maim, save it, and copy to clipboard
FILENAME="$HOME/Pictures/$(date +'%Y-%m-%d_%H-%M-%S').png"
maim -s --format=png /dev/stdout | tee "$FILENAME" | xclip -selection clipboard -t image/png -i

# Check if the screenshot was successfully saved and copied
if [[ -f "$FILENAME" ]]; then
    notify-send "Screenshot" "Screenshot saved and copied to clipboard: $FILENAME"
else
    notify-send "Screenshot" "Failed to take the screenshot."
fi
