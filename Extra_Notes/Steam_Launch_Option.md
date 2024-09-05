## These are unique launch options depending on the game and use case

### Counter-Strike 2 ~ stretched to 1400x1050 on a 1920x1080 240hz Display
gamemoderun xrandr --output DisplayPort-1 --mode "1400x1050_240.00"; %command% ; xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240; %command% -novid +fps_max 0
### reverts back to 1920x1080 @ 240hz when game is closed..
### for some reason game is launch again on second command.. I don't know a solution just MOD+Shift+c to close it.

### Counter-Strike 2 ~ 1024x768 105hz on a CRT
gamemoderun %command% -w 1024 -h 768 -refresh 105 -novid +fps_max 0

### Apex Legends on a CRT
gamemoderun %command% +mat_letterbox_aspect_goal 0 +mat_letterbox_aspect_threshold 0 +building_cubemaps "1" -novid
