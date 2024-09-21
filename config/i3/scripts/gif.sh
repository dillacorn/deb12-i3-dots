#!/bin/bash

# Define the output directory
OUTPUT_DIR="$HOME/Videos"
DURATION=60  # Max duration set to 1 minute (60 seconds)

# Check if byzanz is already running
BYZANZ_PID=$(pgrep -x byzanz-record)

if [ -z "$BYZANZ_PID" ]; then
    # Use slop to get a custom area selection
    read -r GEOMETRY < <(slop --format "%x %y %w %h")

    if [ -n "$GEOMETRY" ]; then
        # Define a temporary filename for the recording
        TEMP_FILENAME="temp_gif_$(date +'%Y-%m-%d_%H-%M-%S').gif"
        TEMP_OUTPUT_FILE="$OUTPUT_DIR/$TEMP_FILENAME"

        # Start recording with byzanz
        echo "Starting recording in selected area for $DURATION seconds..."
        byzanz-record --duration=$DURATION --x=$(echo $GEOMETRY | awk '{print $1}') --y=$(echo $GEOMETRY | awk '{print $2}') --width=$(echo $GEOMETRY | awk '{print $3}') --height=$(echo $GEOMETRY | awk '{print $4}') "$TEMP_OUTPUT_FILE" &

        # Store the PID of the recording process
        echo $! > "$OUTPUT_DIR/byzanz.pid"

        # Wait for the recording to finish
        wait $!
    else
        echo "No area selected, aborting."
    fi
else
    # Stop the recording if byzanz is already running
    echo "Stopping recording..."
    kill "$BYZANZ_PID"

    # Wait for the recording to complete
    wait "$BYZANZ_PID"

    # Prompt the user to enter a name for the GIF using zenity after stopping
    GIF_NAME=$(zenity --entry --title="GIF Name" --text="Enter a name for the GIF (without extension):")

    # Check if the user entered a name; if not, use the default timestamp-based name
    if [ -z "$GIF_NAME" ]; then
        GIF_NAME="gif_$(date +'%Y-%m-%d_%H-%M-%S')"
    else
        GIF_NAME="${GIF_NAME}_$(date +'%Y-%m-%d_%H-%M-%S')"
    fi

    # Rename the temporary file to the user-specified or default name
    TEMP_OUTPUT_FILE="$OUTPUT_DIR/temp_gif_*.gif"
    if ls $TEMP_OUTPUT_FILE 1> /dev/null 2>&1; then
        mv $TEMP_OUTPUT_FILE "$OUTPUT_DIR/$GIF_NAME.gif"
        echo "GIF saved as $OUTPUT_DIR/$GIF_NAME.gif"
    else
        echo "No temporary GIF file found to rename."
    fi

    # Clean up the PID file
    rm "$OUTPUT_DIR/byzanz.pid"
fi
