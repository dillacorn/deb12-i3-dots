## These are unique launch options depending on the game and use case

### Counter-Strike 2 ~ stretched to 1440x1080 on a 1920x1080 240hz Display
gamemoderun gamescope -w 1440 -h 1080 -S stretch -f --force-grab-cursor -- %command% -refresh 240 -novid +fps_max 0

### Counter-Strike 2 ~ 1024x768 105hz on a CRT
gamemoderun %command% -w 1024 -h 768 -refresh 105 -novid +fps_max 0

### Apex Legends on a CRT
gamemoderun %command% +mat_letterbox_aspect_goal 0 +mat_letterbox_aspect_threshold 0 +building_cubemaps "1" -novid
