### These are unique launch options depending on the game and use case for [i3wm](https://github.com/i3/i3) and/or other Xorg/X11 sessions

### before running launch option set a custom resolution see [custom_res.sh](https://github.com/dillacorn/dotfiles/blob/main/config/i3/custom_res.sh)

## Counter-Strike 2 ~ stretched 1400x1050 @ 240hz
gamemoderun xrandr --output DisplayPort-1 --mode "1400x1050_240.00" ; %command% ; xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240; -novid +fps_max 0 

## Counter-Strike 2 ~ 1024x768 105hz on a CRT
gamemoderun %command% -w 1024 -h 768 -refresh 105 -novid +fps_max 0

## Apex Legends ~ 1344x1005 @ 81.67hz on a CRT
### patch apex videoconfig.txt first
gamemoderun xrandr --output DisplayPort-2 --mode "1344x1005_81.67" --pos 0x0 --output DisplayPort-1 --mode 1920x1080 --rate 81.67 --pos 1344x0 ; %command% SettingsDX12.json +mat_letterbox_aspect_goal 0 +mat_letterbox_aspect_threshold 0 +building_cubemaps "1" -novid -freq 81.67 +fps_max unlimited

## The Finals ~ 1344x1005 @ 81.67hz on a CRT
gamemoderun xrandr --output DisplayPort-2 --mode "1344x1005_81.67" --pos 0x0 --output DisplayPort-1 --mode 1920x1080 --rate 81.67 --pos 1344x0 ; %command% ; xrandr --output DisplayPort-2 --off --output DisplayPort-1 --mode 1920x1080 --rate 240 --pos 0x0;

## The Finals ~ stretched 1400x1050 @ 240hz
gamemoderun xrandr --output DisplayPort-1 --mode "1400x1050_240.00" ; %command% ; xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240;
