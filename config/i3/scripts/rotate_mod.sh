#!/bin/bash

# Path to your i3 config file
I3_CONFIG="$HOME/.config/i3/config"

# Check if the current bindings are set to Mod1 or Mod4 by inspecting the first line
if grep -q "bindsym Mod1+p exec rofi -show drun" "$I3_CONFIG"; then
    # Switching from Mod1 (ALT) to Mod4 (META)
    sed -i '
    # Rofi launcher
    s/bindsym Mod1+p/bindsym Mod4+p/;
    s/bindsym Mod1+shift+p/bindsym Mod4+shift+p/;
    
    # Terminal launch
    s/bindsym Mod1+shift+Return/bindsym Mod4+shift+Return/;
    
    # Kill focused window
    s/bindsym Mod1+shift+c/bindsym Mod4+shift+c/;

    # Floating modifier
    s/floating_modifier Mod1/floating_modifier Mod4/;
    
    # Focus window navigation (vim-style keys)
    s/bindsym Mod1+j/bindsym Mod4+j/;
    s/bindsym Mod1+h/bindsym Mod4+h/;
    s/bindsym Mod1+k/bindsym Mod4+k/;
    s/bindsym Mod1+l/bindsym Mod4+l/;
    
    # Focus window navigation (arrow keys)
    s/bindsym Mod1+Left/bindsym Mod4+Left/;
    s/bindsym Mod1+Down/bindsym Mod4+Down/;
    s/bindsym Mod1+Up/bindsym Mod4+Up/;
    s/bindsym Mod1+Right/bindsym Mod4+Right/;
    
    # Move focused window
    s/bindsym Mod1+shift+h/bindsym Mod4+shift+h/;
    s/bindsym Mod1+shift+j/bindsym Mod4+shift+j/;
    s/bindsym Mod1+shift+k/bindsym Mod4+shift+k/;
    s/bindsym Mod1+shift+l/bindsym Mod4+shift+l/;
    
    # Move focused window (arrow keys)
    s/bindsym Mod1+shift+Left/bindsym Mod4+shift+Left/;
    s/bindsym Mod1+shift+Down/bindsym Mod4+shift+Down/;
    s/bindsym Mod1+shift+Up/bindsym Mod4+shift+Up/;
    s/bindsym Mod1+shift+Right/bindsym Mod4+shift+Right/;
    
    # Workspace switching
    s/bindsym Mod1+1/bindsym Mod4+1/;
    s/bindsym Mod1+2/bindsym Mod4+2/;
    s/bindsym Mod1+3/bindsym Mod4+3/;
    s/bindsym Mod1+4/bindsym Mod4+4/;
    s/bindsym Mod1+5/bindsym Mod4+5/;
    s/bindsym Mod1+6/bindsym Mod4+6/;
    s/bindsym Mod1+7/bindsym Mod4+7/;
    s/bindsym Mod1+8/bindsym Mod4+8/;
    s/bindsym Mod1+9/bindsym Mod4+9/;
    s/bindsym Mod1+0/bindsym Mod4+0/;
    
    # Move focused window to workspace
    s/bindsym Mod1+shift+1/bindsym Mod4+shift+1/;
    s/bindsym Mod1+shift+2/bindsym Mod4+shift+2/;
    s/bindsym Mod1+shift+3/bindsym Mod4+shift+3/;
    s/bindsym Mod1+shift+4/bindsym Mod4+shift+4/;
    s/bindsym Mod1+shift+5/bindsym Mod4+shift+5/;
    s/bindsym Mod1+shift+6/bindsym Mod4+shift+6/;
    s/bindsym Mod1+shift+7/bindsym Mod4+shift+7/;
    s/bindsym Mod1+shift+8/bindsym Mod4+shift+8/;
    s/bindsym Mod1+shift+9/bindsym Mod4+shift+9/;
    s/bindsym Mod1+shift+0/bindsym Mod4+shift+0/;
    
    # Fullscreen and floating window toggling
    s/bindsym Mod1+shift+f/bindsym Mod4+shift+f/;
    s/bindsym Mod1+f/bindsym Mod4+f/;
    
    # Resizing windows
    s/bindsym Mod1+ctrl+Right/bindsym Mod4+ctrl+Right/;
    s/bindsym Mod1+ctrl+Up/bindsym Mod4+ctrl+Up/;
    s/bindsym Mod1+ctrl+Down/bindsym Mod4+ctrl+Down/;
    s/bindsym Mod1+ctrl+Left/bindsym Mod4+ctrl+Left/;
    
    # Resizing windows (vim keys)
    s/bindsym Mod1+ctrl+l/bindsym Mod4+ctrl+l/;
    s/bindsym Mod1+ctrl+k/bindsym Mod4+ctrl+k/;
    s/bindsym Mod1+ctrl+j/bindsym Mod4+ctrl+j/;
    s/bindsym Mod1+ctrl+h/bindsym Mod4+ctrl+h/;
    
    # Adjust gaps (inner and outer)
    s/bindsym Mod1+ctrl+plus/bindsym Mod4+ctrl+plus/;
    s/bindsym Mod1+ctrl+minus/bindsym Mod4+ctrl+minus/;
    s/bindsym Mod1+ctrl+shift+plus/bindsym Mod4+ctrl+shift+plus/;
    s/bindsym Mod1+ctrl+shift+minus/bindsym Mod4+ctrl+shift+minus/' "$I3_CONFIG"
    
    # Dunst notification for Mod4 toggle
    notify-send "mod4 toggled (META)"
else
    # Switching from Mod4 (META) to Mod1 (ALT)
    sed -i '
    # Rofi launcher
    s/bindsym Mod4+p/bindsym Mod1+p/;
    s/bindsym Mod4+shift+p/bindsym Mod1+shift+p/;
    
    # Terminal launch
    s/bindsym Mod4+shift+Return/bindsym Mod1+shift+Return/;
    
    # Kill focused window
    s/bindsym Mod4+shift+c/bindsym Mod1+shift+c/;

    # Floating modifier
    s/floating_modifier Mod4/floating_modifier Mod1/;
   
    # Focus window navigation (vim-style keys)
    s/bindsym Mod4+j/bindsym Mod1+j/;
    s/bindsym Mod4+h/bindsym Mod1+h/;
    s/bindsym Mod4+k/bindsym Mod1+k/;
    s/bindsym Mod4+l/bindsym Mod1+l/;
    
    # Focus window navigation (arrow keys)
    s/bindsym Mod4+Left/bindsym Mod1+Left/;
    s/bindsym Mod4+Down/bindsym Mod1+Down/;
    s/bindsym Mod4+Up/bindsym Mod1+Up/;
    s/bindsym Mod4+Right/bindsym Mod1+Right/;
    
    # Move focused window
    s/bindsym Mod4+shift+h/bindsym Mod1+shift+h/;
    s/bindsym Mod4+shift+j/bindsym Mod1+shift+j/;
    s/bindsym Mod4+shift+k/bindsym Mod1+shift+k/;
    s/bindsym Mod4+shift+l/bindsym Mod1+shift+l/;
    
    # Move focused window (arrow keys)
    s/bindsym Mod4+shift+Left/bindsym Mod1+shift+Left/;
    s/bindsym Mod4+shift+Down/bindsym Mod1+shift+Down/;
    s/bindsym Mod4+shift+Up/bindsym Mod1+shift+Up/;
    s/bindsym Mod4+shift+Right/bindsym Mod1+shift+Right/;
    
    # Workspace switching
    s/bindsym Mod4+1/bindsym Mod1+1/;
    s/bindsym Mod4+2/bindsym Mod1+2/;
    s/bindsym Mod4+3/bindsym Mod1+3/;
    s/bindsym Mod4+4/bindsym Mod1+4/;
    s/bindsym Mod4+5/bindsym Mod1+5/;
    s/bindsym Mod4+6/bindsym Mod1+6/;
    s/bindsym Mod4+7/bindsym Mod1+7/;
    s/bindsym Mod4+8/bindsym Mod1+8/;
    s/bindsym Mod4+9/bindsym Mod1+9/;
    s/bindsym Mod4+0/bindsym Mod1+0/;
    
    # Move focused window to workspace
    s/bindsym Mod4+shift+1/bindsym Mod1+shift+1/;
    s/bindsym Mod4+shift+2/bindsym Mod1+shift+2/;
    s/bindsym Mod4+shift+3/bindsym Mod1+shift+3/;
    s/bindsym Mod4+shift+4/bindsym Mod1+shift+4/;
    s/bindsym Mod4+shift+5/bindsym Mod1+shift+5/;
    s/bindsym Mod4+shift+6/bindsym Mod1+shift+6/;
    s/bindsym Mod4+shift+7/bindsym Mod1+shift+7/;
    s/bindsym Mod4+shift+8/bindsym Mod1+shift+8/;
    s/bindsym Mod4+shift+9/bindsym Mod1+shift+9/;
    s/bindsym Mod4+shift+0/bindsym Mod1+shift+0/;
    
    # Fullscreen and floating window toggling
    s/bindsym Mod4+shift+f/bindsym Mod1+shift+f/;
    s/bindsym Mod4+f/bindsym Mod1+f/;
    
    # Resizing windows
    s/bindsym Mod4+ctrl+Right/bindsym Mod1+ctrl+Right/;
    s/bindsym Mod4+ctrl+Up/bindsym Mod1+ctrl+Up/;
    s/bindsym Mod4+ctrl+Down/bindsym Mod1+ctrl+Down/;
    s/bindsym Mod4+ctrl+Left/bindsym Mod1+ctrl+Left/;
    
    # Resizing windows (vim keys)
    s/bindsym Mod4+ctrl+l/bindsym Mod1+ctrl+l/;
    s/bindsym Mod4+ctrl+k/bindsym Mod1+ctrl+k/;
    s/bindsym Mod4+ctrl+j/bindsym Mod1+ctrl+j/;
    s/bindsym Mod4+ctrl+h/bindsym Mod1+ctrl+h/;
    
    # Adjust gaps (inner and outer)
    s/bindsym Mod4+ctrl+plus/bindsym Mod1+ctrl+plus/;
    s/bindsym Mod4+ctrl+minus/bindsym Mod1+ctrl+minus/;
    s/bindsym Mod4+ctrl+shift+plus/bindsym Mod1+ctrl+shift+plus/;
    s/bindsym Mod4+ctrl+shift+minus/bindsym Mod1+ctrl+shift+minus/' "$I3_CONFIG"

    # Dunst notification for Mod1 toggle
    notify-send "mod1 toggled (ALT)"
fi

# Reload i3 to apply the changes
i3-msg reload