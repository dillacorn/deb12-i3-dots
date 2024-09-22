#!/bin/bash

# Define the output directory
OUTPUT_DIR="$HOME/Videos"

# Generate a filename with date and time (e.g., gif_2024-09-21_20-23-23.gif)
FILENAME="gif_$(date +'%Y-%m-%d_%H-%M-%S').gif"
OUTPUT_FILE="$OUTPUT_DIR/$FILENAME"

# Set max duration (60 seconds)
DURATION=60

# Check if ffmpeg is already running (i.e., recording is in progress)
FFMPEG_PID=$(pgrep -x ffmpeg)

if [ -z "$FFMPEG_PID" ]; then
    # Use slop to select screen area for recording
    read -r GEOMETRY < <(slop --format "%x %y %w %h")

    if [ -n "$GEOMETRY" ]; then
        # Split the geometry into separate variables
        X=$(echo $GEOMETRY | awk '{print $1}')
        Y=$(echo $GEOMETRY | awk '{print $2}')
        WIDTH=$(echo $GEOMETRY | awk '{print $3}')
        HEIGHT=$(echo $GEOMETRY | awk '{print $4}')

        # Generate a color palette first
        echo "Generating palette..."
        ffmpeg -y -f x11grab -video_size "${WIDTH}x${HEIGHT}" \
               -framerate 20 -i "$DISPLAY+$X,$Y" \
               -t $DURATION -vf "fps=20,palettegen" palette.png

        # Create the GIF using the generated palette
        echo "Creating GIF..."
        ffmpeg -y -f x11grab -video_size "${WIDTH}x${HEIGHT}" \
               -framerate 20 -i "$DISPLAY+$X,$Y" \
               -t $DURATION -i palette.png -lavfi "fps=20,paletteuse" "$OUTPUT_FILE" &
        
        echo "Recording... Run the script again to stop it."
    else
        echo "No area selected, aborting."
    fi
else
    # Stop the recording if ffmpeg is already running
    echo "Stopping recording and saving as $OUTPUT_FILE..."
    kill "$FFMPEG_PID"
fi
