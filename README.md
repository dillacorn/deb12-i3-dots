# `dilla.files`
distro: [`debian`](https://www.debian.org/) | wayland: [`swaywm`](https://github.com/swaywm/sway) | kernal: [`linux-tkg`](https://github.com/Frogging-Family/linux-tkg)

wallpapers
-----------------------------------------------------------------------------------------

[gruvbox](https://github.com/AngelJumbo/gruvbox-wallpapers) by [AngelJumbo](https://github.com/AngelJumbo)

[aesthetic-wallpapers](https://github.com/D3Ext/aesthetic-wallpapers) by [D3Ext](https://github.com/D3Ext)

SnapKey for Linux
-----------------------------------------------------------------------------------------

I'm the OP -> [Guide for SnapKey on Linux!](https://github.com/cafali/SnapKey/wiki/Setup-Linux)

Visit Repo -> [Snapkey Repo](https://github.com/cafali/SnapKey)

Keyboard at time of post -> [Gamakay TK68 HE](https://gamakay.com/products/gamakay-tk68-he-65-hall-effect-wireless-custom-keyboard?variant=43840647463101)

Reddit Post with cannonkeys keycaps -> [TK68 HE w/ CannonKeys CXA iara](https://www.reddit.com/r/MechanicalKeyboards/comments/1dlecqk/gamakay_tk68_he_cannonkeys_cxa_lara/)

sway commands
-----------------------------------------------------------------------------------------

READ sway [config for keybinds](https://github.com/Dillacorn/dotfiles/blob/caf426ab0752ec1d72704f42f81f8dfa4ac39a59/config/sway/config)

Using both `MOD1(ALT)` and `MOD4(win)` in config

terminal commands
-----------------------------------------------------------------------------------------

`CTRL+l` <- clears console

`CTRL+a` <- goes to beginning of line

`CTRL+e` <- goes to end of line

`CTRL+k` <- deletes from cursor to end of line

`CTRL+left` or `CTRL+right` <- forward and backward words

`Shift+PgUp` or `Shift+PgDwn` <- up and down terminal (faster than scrolling)

more commands to learn -> [learning-command-line](https://github.com/LinkedInLearning/learning-linux-command-line-3005201/blob/e0cfdc8244b804b57c04b5cffc55c0b322122457/commands.md) by [LinkedInLearning](https://github.com/LinkedInLearning)

my sway keybinds
-----------------------------------------------------------------------------------------

My keybinds are [suckless DWM](https://dwm.suckless.org/) inspired. Previously used [DWM Flexipatch](https://github.com/bakkeby/dwm-flexipatch) by [bakkeby](https://github.com/bakkeby) DWM was my first window manager. My keybinds have been reconfigured for easier adoption and transition.

screw display managers...full stop...
-----------------------------------------------------------------------------------------

I've had the most issues with display (login) managers, so I prefer TTY. To remove your display manager, use:

```sh
`sudo apt remove gdm3 sddm lightdm`
```

Login by typing your username and password, then start Sway from TTY by typing:

```sh
`sway`
```

If you encounter issues, switch TTYs with CTRL+ALT+F1 to F6.

No need to thank me, thank Linux! Another reason why Linux is the best operating system.

TL;DR

Want to keep your display manager? Try `ly` -> [github/ly](https://github.com/fairyglade/ly) by [fairyglade](https://github.com/fairyglade)

converting sway config to i3?
-----------------------------------------------------------------------------------------

I use the ~/.config directory to store i3 and Sway. Command to check errors for i3 conversion:

```sh
`i3 -C -c ~/.config/i3/config`
```

good luck!

have an nvidia GPU?
-----------------------------------------------------------------------------------------

Nvidia GPU fix for [Sway](https://github.com/swaywm/sway) -> [github/sway-nvidia](https://github.com/crispyricepc/sway-nvidia) by [crispyricepc](https://github.com/crispyricepc) or use [i3 wm](https://github.com/i3/i3) instead?

run a script in scripts folder
-----------------------------------------------------------------------------------------

example:

```sh
cd ~/Downloads/dotfiles/scripts`
chmod +x install_my_apps.sh
sudo ./install_my_apps.sh
```
