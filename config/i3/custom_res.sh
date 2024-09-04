#!/bin/bash

# xrandr --output DisplayPort-2 --off
# for when I don't want to use my CRT

# get modeline string for xrandr using gtf and/or cvt
gtf 1024 768 105.39
gtf 1152 864 94.3
gtf 1600 1200 68.91

# adding gtf/cvt output as a newmode for xrandr to use
## xrandr --newmode "1152x864_94.00"  133.25  1152 1232 1352 1552  864 867 871 915 -hsync +vsync
xrandr --newmode "1024x768_105.39"  119.71  1024 1096 1208 1392  768 769 772 816  -HSync +Vsync
xrandr --newmode "1152x864_94.30"  134.85  1152 1232 1360 1568  864 865 868 912  -HSync +Vsync
xrandr --newmode "1600x1200_68.91"  187.14  1600 1712 1888 2176  1200 1201 1204 1248  -HSync +Vsync

# apply newmode to specific CRT
xrandr --addmode DisplayPort-2 "1024x768_105.39"
xrandr --addmode DisplayPort-2 "1152x864_94.30"
xrandr --addmode DisplayPort "1600x1200_68.91"

# apply output mode to CRT
xrandr --output DisplayPort-2 --mode "1024x768_105.39" --pos 0x0 --rotate normal
# xrandr --output DisplayPort-2 --mode "1152x864_94.30" --pos 0x0 --rotate normal
# xrandr --output DisplayPort-2 --mode "1600x1200_68.91" --pos 0x0 --rotate normal

# additional xrandr settings here
# ViewSonic XG2431 (capped to 94hz to reduce crosstalk)
xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240 --pos 1024x0 --rotate normal
# adjust "--pos" depending on DisplayPort-2 resolution

# xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240 --pos 0x0 --rotate normal
# for when the CRT is turned off
