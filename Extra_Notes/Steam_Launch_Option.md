### These are unique launch options depending on the game and use case

### before running launch option set a custom resolution see [custom_res.sh](https://github.com/dillacorn/dotfiles/blob/main/config/i3/custom_res.sh)

## Counter-Strike 2 ~ stretched 1400x1050 @ 240hz
gamemoderun xrandr --output DisplayPort-1 --mode "1400x1050_240.00" ; %command% ; xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240; -novid +fps_max 0 

## Counter-Strike 2 ~ 1024x768 105hz on a CRT
gamemoderun %command% -w 1024 -h 768 -refresh 105 -novid +fps_max 0

## Apex Legends on a CRT
gamemoderun %command% +mat_letterbox_aspect_goal 0 +mat_letterbox_aspect_threshold 0 +building_cubemaps "1" -novid

## The Finals ~ stretched 1400x1050 @ 240hz
gamemoderun xrandr --output DisplayPort-1 --mode "1400x1050_240.00" ; %command% ; xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240;
