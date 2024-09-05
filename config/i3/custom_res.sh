#!/bin/bash

# turn off CRT
xrandr --output DisplayPort-2 --off

# get modeline string for xrandr using gtf and/or cvt 
# [CRT ~ Compaq FS7550]
gtf 1024 768 105.39
gtf 1152 864 94.3
gtf 1340 1005 81.67
gtf 1600 1200 68.91

# get modeline string for xrandr using gtf and/or cvt 
# [IPS 1080p 240hz ~ ViewSonic XG2431]
gtf 1400 1050 240

# adding gtf/cvt output as a newmode for xrandr to use
# [CRT ~ Compaq FS7550]
## xrandr --newmode "1152x864_94.00"  133.25  1152 1232 1352 1552  864 867 871 915 -hsync +vsync
xrandr --newmode "1024x768_105.39"  119.71  1024 1096 1208 1392  768 769 772 816  -HSync +Vsync
xrandr --newmode "1152x864_94.30"  134.85  1152 1232 1360 1568  864 865 868 912  -HSync +Vsync
xrandr --newmode "1344x1005_81.67"  156.86  1344 1440 1584 1824  1005 1006 1009 1053  -HSync +Vsync
xrandr --newmode "1600x1200_68.91"  187.14  1600 1712 1888 2176  1200 1201 1204 1248  -HSync +Vsync

# adding gtf/cvt output as a newmode for xrandr to use
# [IPS 1080p 240hz ~ ViewSonic XG2431]
xrandr --newmode "1400x1050_240.00"  570.50  1400 1528 1680 1960  1050 1053 1057 1214 -hsync +vsync

# apply newmode to specific output
# [CRT ~ Compaq FS7550]
xrandr --addmode DisplayPort-2 "1024x768_105.39"
xrandr --addmode DisplayPort-2 "1152x864_94.30"
xrandr --addmode DisplayPort-2 "1344x1005_81.67"
xrandr --addmode DisplayPort-2 "1600x1200_68.91"

# apply newmode to specific output
# [IPS 1080p 240hz ~ ViewSonic XG2431]
xrandr --addmode DisplayPort-1 "1400x1050_240.00"

# apply output mode to CRT
# xrandr --output DisplayPort-2 --mode "1024x768_105.39" --pos 0x0 --rotate normal
# xrandr --output DisplayPort-2 --mode "1152x864_94.30" --pos 0x0 --rotate normal
# xrandr --output DisplayPort-2 --mode "1344x1005_81.67" --pos 0x0 --rotate normal
# xrandr --output DisplayPort-2 --mode "1600x1200_68.91" --pos 0x0 --roate normal

# additional xrandr settings here
# ViewSonic XG2431 (capped to 94hz to reduce crosstalk)
xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240 --pos 0x0 --rotate normal
# adjust "--pos 1024x0, 1152x0, 1344x0, 1600x0" depending on CRT configuration
