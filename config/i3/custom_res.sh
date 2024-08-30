#!/bin/bash

# get modeline string for xrandr
# this is for a CRT monitor
gtf 1440 1080 75

# adding gtf output as a newmode for xrandr to use.
xrandr --newmode "1440x1080_75.00"  165.14  1440 1536 1696 1952  1080 1081 1084 1128  -HSync +Vsync

# apply newmode to specific display
xrandr --addmode HDMI-A-0 "1440x1080_75.00"

# apply output mode to display
xrandr --output HDMI-A-0 --mode "1440x1080_75.00"

# additional xrandr settings here
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 240 --right-of HDMI-A-0
