# not sure if this works yet... just testing
### These are unique launch options depending on the game and use case for [sway](https://github.com/swaywm/sway)

### before running launch option set a custom resolution see `man sway-outputs`

## Counter-Strike 2 ~ stretched 1352x1080 240hz
gamemoderun swaymsg output DP-2 mode --custom 1352x1080@240Hz max_render_time off ; %command% ; swaymsg output DP-2 res 1920x1080@240Hz; -novid +fps_max 0 

## Counter-Strike 2 ~ 1024x768 105hz on a CRT
gamemoderun swaymsg output DP-3 mode --custom 1024x768@105Hz max_render_time off %command% -w 1024 -h 768 -refresh 105 -novid +fps_max 0

## Apex Legends ~ stretched 1400x1050 240hz
### patch apex videoconfig.txt then make read-only

`micro ~/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/compatdata/1172470/pfx/drive_c/users/steamuser/Saved\ Games/Respawn/Apex/local/videoconfig.txt`

	"setting.defaultres"		"1400"
	"setting.defaultresheight"		"1050"

gamemoderun swaymsg output DP-2 mode 1920x1080@240Hz max_render_time off %command% -anticheat_settings=SettingsDX12.json +mat_letterbox_aspect_goal 0 +mat_letterbox_aspect_threshold 0 +building_cubemaps "1" -dev -freq 240 +fps_max unlimited

## Apex Legends ~ 1344x1005 81.67hz on a CRT
### patch apex videoconfig.txt then make read-only

`micro ~/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/compatdata/1172470/pfx/drive_c/users/steamuser/Saved\ Games/Respawn/Apex/local/videoconfig.txt`

	"setting.defaultres"		"1344"
	"setting.defaultresheight"		"1005"

gamemoderun swaymsg output DP-3 mode --custom 1344x1005@81.67Hz pos 0,0 max_render_time off output DP-2 mode --custom 1920x1080@81.67hz pos 1344,0 max_render_time off %command% -anticheat_settings=SettingsDX12.json +mat_letterbox_aspect_goal 0 +mat_letterbox_aspect_threshold 0 +building_cubemaps "1" -dev -freq 81.67 +fps_max unlimited

## The Finals ~ 1344x1005 81.67hz on a CRT
gamemoderun swaymsg output DP-3 mode --custom 1344x1005@81.67Hz pos 0,0 max_render_time off output DP-2 mode --custom 1920x1080@81.67Hz pos 1344,0 max_render_time off %command%

## The Finals ~ stretched 1352x1080 240hz
gamemoderun swaymsg output DP-2 mode --custom 1352x1080@240Hz max_render_time off ; %command% ; swaymsg output DP-2 mode 1920x1080@240Hz;
