Notes From Repo: https://github.com/dillacorn/deb12-i3-dots

### These are unique launch options depending on the game and use case for [i3wm](https://github.com/i3/i3) and/or other Xorg/X11 sessions

### before running launch option set a custom resolution see [custom_res.sh](https://github.com/dillacorn/deb12-i3-dots/blob/main/config/i3/custom_res.sh)

## Counter-Strike 2 ~ stretched 1352x1080 240hz
xrandr --output DisplayPort-1 --mode "1352x1080_240.00" ; gamemoderun ; %command% -novid +fps_max 0; xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240

## Counter-Strike 2 ~ 1024x768 105hz on a CRT
gamemoderun ; %command% -w 1024 -h 768 -refresh 105 -novid +fps_max 0

## Apex Legends ~ stretched 1400x1050 240hz
### patch apex videoconfig.txt then make read-only

`micro ~/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/compatdata/1172470/pfx/drive_c/users/steamuser/Saved\ Games/Respawn/Apex/local/videoconfig.txt`

	"setting.defaultres"		"1400"
	"setting.defaultresheight"		"1050"

gamemoderun ; %command% -anticheat_settings=SettingsDX12.json +mat_letterbox_aspect_goal 0 +mat_letterbox_aspect_threshold 0 +building_cubemaps "1" -dev -freq 240 +fps_max unlimited

## Apex Legends ~ 1344x1005 81.67hz on a CRT
### patch apex videoconfig.txt then make read-only

`micro ~/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/compatdata/1172470/pfx/drive_c/users/steamuser/Saved\ Games/Respawn/Apex/local/videoconfig.txt`

	"setting.defaultres"		"1344"
	"setting.defaultresheight"		"1005"

xrandr --output DisplayPort-2 --mode "1344x1005_81.67" --pos 0x0 --output DisplayPort-1 --mode 1920x1080 --rate 81.67 --pos 1344x0 ; gamemoderun ; %command% -anticheat_settings=SettingsDX12.json +mat_letterbox_aspect_goal 0 +mat_letterbox_aspect_threshold 0 +building_cubemaps "1" -dev -freq 81.67 +fps_max unlimited

## The Finals ~ 1344x1005 81.67hz on a CRT
xrandr --output DisplayPort-2 --mode "1344x1005_81.67" --pos 0x0 --output DisplayPort-1 --mode 1920x1080 --rate 81.67 --pos 1344x0 ; gamemoderun ; %command% PROTON_USE_EAC_LINUX=1 ; xrandr --output DisplayPort-2 --off --output DisplayPort-1 --mode 1920x1080 --rate 240 --pos 0x0

## The Finals ~ stretched 1352x1080 240hz
xrandr --output DisplayPort-1 --mode "1352x1080_240.00" ; gamemoderun ; %command% PROTON_USE_EAC_LINUX=1 ; xrandr --output DisplayPort-1 --mode 1920x1080 --rate 240
