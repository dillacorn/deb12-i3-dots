#!/bin/bash

# get modeline string for xrandr
gtf 1152 864 94

# adding gtf output as a newmode for xrandr to use.
xrandr --newmode "1152x864_94.00"  134.42  1152 1232 1360 1568  864 865 868 912  -HSync +Vsync

# apply newmode to specific display
xrandr --addmode DisplayPort-2 "1152x864_94.00"

# apply output mode to display
xrandr --output DisplayPort-2 --mode "1152x864_94.00" --pos 0x0 --rotate normal
# applied to Compaq FS7550 (CRT monitor)

# additional xrandr settings here
# ViewSonic XG2431 (capped to 94hz to reduce crosstalk)
xrandr --output DisplayPort-1 --mode 1920x1080 --rate 94 --pos 1152x0 --rotate normal
