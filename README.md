# `dilla.files`
distro: [`debian sid`](https://www.debian.org/releases/sid/) | wayland: [`swaywm`](https://github.com/swaywm/sway) | kernal: [`linux-tkg`](https://github.com/Frogging-Family/linux-tkg) - [`install linux-tkg on debian`](https://github.com/Frogging-Family/linux-tkg?tab=readme-ov-file#deb-debian-ubuntu-and-derivatives-and-rpm-fedora-suse-and-derivatives-based-distributions)

### `~click picture!~`
[![preview](https://i.imgur.com/1JOMnpC.png)](https://youtu.be/sL1O7zuQIuE)

# my sway keybinds

My [keybinds](https://github.com/dillacorn/dotfiles/blob/main/config/sway/config) are [suckless DWM](https://dwm.suckless.org/) inspired. + [alternative config for MOD4 only keybinds](https://github.com/Dillacorn/dotfiles/blob/main/config/sway/super.config)

Previously used [DWM Flexipatch](https://github.com/bakkeby/dwm-flexipatch) by [bakkeby](https://github.com/bakkeby) ~ DWM was my very first window manager.

# wallpapers

[gruvbox](https://github.com/AngelJumbo/gruvbox-wallpapers) by [AngelJumbo](https://github.com/AngelJumbo)

[aesthetic-wallpapers](https://github.com/D3Ext/aesthetic-wallpapers) by [D3Ext](https://github.com/D3Ext)

# sway commands

READ sway [default config for keybinds](https://github.com/dillacorn/dotfiles/blob/main/config/sway/config) + [alternative config for MOD4 only keybinds](https://github.com/Dillacorn/dotfiles/blob/main/config/sway/super.config)

Using both `MOD1(ALT)` and `MOD4(win/super)` in default config

`MOD4+shift+q` = reloads config

`MOD4+shift+r` = rotates alternative sway configurations -> [see ~/.config/sway directory](https://github.com/Dillacorn/dotfiles/tree/main/config/sway)

`MOD4+shift+g` = capture a gif with script <- `repeat keybind to finish command!`

`MOD4+shift+s` = grimshot screenshot

`MOD4+ctrl+shift+s` = flameshot screenshot

# terminal navigation

`CTRL+l` <- clears console

`CTRL+a` <- goes to beginning of line

`CTRL+e` <- goes to end of line

`CTRL+k` <- deletes from cursor to end of line

`CTRL+left` or `CTRL+right` <- forward and backward words

`Shift+PgUp` or `Shift+PgDwn` <- up and down terminal (faster than scrolling)

more commands to learn -> [learning-command-line](https://github.com/LinkedInLearning/learning-linux-command-line-3005201/blob/e0cfdc8244b804b57c04b5cffc55c0b322122457/commands.md) by [LinkedInLearning](https://github.com/LinkedInLearning)

# run a script in scripts folder

example:

```sh
cd ~/dotfiles/scripts
chmod +x install_my_apps.sh
sudo ./install_my_apps.sh
```

# screw display managers...full stop...

I've had the most issues with display (login) managers, so I prefer TTY. To remove your display manager, use:

```sh
sudo apt remove gdm3 sddm lightdm
```

Login by typing your username and password, then start Sway from TTY by typing:

```sh
sway
```

If you encounter issues, switch TTYs with CTRL+ALT+F1 to F6.

# have an nvidia GPU?

Use [i3 wm](https://github.com/i3/i3) instead till Nvidia is fully supported... or if you just like X11 over Wayland due to strange behavior and/or bugs with your specific hardware.

Match or modify `xinitrc` as described [here](https://github.com/dillacorn/dotfiles/blob/main/etc/X11/xinit/xinitrc) so i3 can be started in TTY with `startx` command

Run app [install script](https://github.com/dillacorn/dotfiles/blob/main/scripts/install_my_i3_apps.sh) to get my apps which also includes i3wm

```sh
git clone https://github.com/dillacorn/dotfiles
cd dotfiles/scripts
chmod +x install_my_i3_apps.sh
./install_my_i3_apps.sh
```

Here is my [i3 configuration](https://github.com/dillacorn/dotfiles/tree/main/config/i3) files you will need to copy to appropiate directory

You also need [rofi](https://github.com/dillacorn/dotfiles/tree/main/config/rofi) and [dunst](https://github.com/dillacorn/dotfiles/tree/main/config/dunst) config files

```sh
cp -r dotfiles/config/i3 ~/.config
cp -r dotfiles/dunst ~/.config
cp -r dotfiles/rofi ~/.config
```

### mod4(win)+ctrl+shift+q = restart and reload i3 session

# converting sway config to i3?

I use the ~/.config directory to store i3 and Sway. Command to check errors for Sway to i3 config conversion:

```sh
i3 -C -c ~/.config/i3/config
```

good luck!
