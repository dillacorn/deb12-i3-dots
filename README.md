# `dilla.files`
distro: [`debian`](https://www.debian.org) | X11: [`i3-wm`](https://github.com/i3/i3) | kernal: [`linux-tkg`](https://github.com/Frogging-Family/linux-tkg) - [`install linux-tkg on debian`](https://github.com/Frogging-Family/linux-tkg?tab=readme-ov-file#deb-debian-ubuntu-and-derivatives-and-rpm-fedora-suse-and-derivatives-based-distributions)

# my keybinds are **DWM** inspired

My keybinds (see [**i3**](https://github.com/dillacorn/dotfiles/blob/main/config/i3/config)) are [**suckless DWM**](https://dwm.suckless.org/) inspired.

Previously used [**DWM Flexipatch**](https://github.com/bakkeby/dwm-flexipatch) by [bakkeby](https://github.com/bakkeby) ~ DWM was my very first window manager.

# wallpapers

[gruvbox](https://github.com/AngelJumbo/gruvbox-wallpapers) by [AngelJumbo](https://github.com/AngelJumbo)

[aesthetic-wallpapers](https://github.com/D3Ext/aesthetic-wallpapers) by [D3Ext](https://github.com/D3Ext)

# i3 themes change script!

```sh
cd ~/.config/i3/themes
chmod +x *
```

using rofi to select theme

`mod4+shift+t`

enjoy! I scripted this myself!

# keybind commands/navigation

READ [i3](https://github.com/dillacorn/dotfiles/blob/main/config/i3/config) config for keybinds + alternative [i3](https://github.com/dillacorn/dotfiles/blob/main/config/i3/super_navigation.config) config for mod4(win/super) navigation keybinds

Using both `mod1(alt)` and `mod4(win/super)` in default config depending on use.

`mod4+shift+q` = reloads config

`mod4+shift+r` = rotates i3 navigation configurations -> [i3 dir.](https://github.com/Dillacorn/dotfiles/tree/main/config/i3)

`mod4+shift+g` = capture a gif with script <- `repeat keybind to finish command! ~ **work in process on i3**`

`mod4+shift+s` = scrot screenshot

`mod4+ctrl+shift+s` = flameshot screenshot

# terminal navigation

`ctrl+l` <- clears console

`ctrl+a` <- goes to beginning of line

`ctrl+e` <- goes to end of line

`ctrl+k` <- deletes from cursor to end of line

`ctrl+left` or `ctrl+right` <- forward and backward words

`shift+PgUp` or `shift+PgDwn` <- up and down terminal (faster than scrolling)

more commands to learn -> [learning-command-line](https://github.com/LinkedInLearning/learning-linux-command-line-3005201/blob/e0cfdc8244b804b57c04b5cffc55c0b322122457/commands.md) by [LinkedInLearning](https://github.com/LinkedInLearning)

# run a script in [scripts folder](https://github.com/dillacorn/dotfiles/tree/main/scripts)

example:

### NOTE: run these commands individually

```sh
cd ~/dotfiles/scripts
chmod +x install_my_apps.sh
sudo ./install_my_apps.sh
```

# drop the display managers...full stop...

I've had the most issues with display (login) managers, so I prefer TTY. To remove your display manager, use:

```sh
sudo apt remove gdm3 sddm lightdm
```

Login by typing your username and password, then start i3 from TTY by typing:

Edit xinitrc first

```sh
micro /etc/X11/xinit/xinitrc
```

match my [**xinitrc**](https://github.com/dillacorn/dotfiles/blob/main/etc/X11/xinit/xinitrc)

### start **i3**
```sh
startx
```

If you encounter issues, switch TTYs with CTRL+ALT+F1 to F6.

### I've discovered!
**HUGE PRO** to using the **TTY** is if you have `i3` config issues or an application is experiencing errors when you logout of `i3` you will see those errors in the **TTY!**

# manual install directions

### git clone my repository

### NOTE: run these commands individually

```sh
sudo apt install git
git clone https://github.com/dillacorn/dotfiles
```

Modify **`xinitrc`** as described [here](https://github.com/dillacorn/dotfiles/blob/main/etc/X11/xinit/xinitrc) so **`i3`** can be started in **TTY** with `startx` command

### **Important:** Make sure **xrandr** command is configured correctly for your display!

```sh
xrandr
```
see output

replace line in **`i3 config`**

```sh
exec --no-startup-id xrandr --output Virtual-1 --mode 1920x1080 --rate 60
```

replace example: (two monitors in example)

```sh
exec --no-startup-id xrandr --output DisplayPort-2 --mode 1920x1080 --rate 240 --pos 0x0 --output HDMI-0 --mode 1920x1080 --rate 60 --pos 1920x0
```

### or modify (custom_res.sh)[https://github.com/dillacorn/dotfiles/blob/main/config/i3/custom_res.sh]

## Tip:
using **`arandr`** can help for getting the correct output code when dealing with multiple displays

### Install i3 apps I use with my script! ~ feel free to redact applications if you don't use them

### NOTE: run these commands individually

Run app [install script](https://github.com/dillacorn/dotfiles/blob/main/scripts/install_my_i3_apps.sh) to get my apps which also includes i3wm

```sh
cd dotfiles/scripts
chmod +x install_my_i3_apps.sh
sudo ./install_my_i3_apps.sh
```

Here is my [i3 configuration](https://github.com/dillacorn/dotfiles/tree/main/config/i3) files you will need to copy to appropiate directory

You also need [rofi](https://github.com/dillacorn/dotfiles/tree/main/config/rofi) and [dunst](https://github.com/dillacorn/dotfiles/tree/main/config/dunst) config files

### NOTE: run these commands individually

```sh
cp -r dotfiles/config/i3 ~/.config
cp -r dotfiles/config/dunst ~/.config
cp -r dotfiles/config/rofi ~/.config
```

Make scripts [i3 configuration](https://github.com/dillacorn/dotfiles/tree/main/config/i3) executable

### NOTE: run these commands individually

```sh
cd ~/.config/i3
chmod +x rotate_configs.sh i3exit.sh custom_res.sh
```

### mod4(win/super)+shift+q = restarts i3 session

# thanks for reading!
### P.S. 
### This originally started out as a wayland repo if you see the git history... at the time I actually liked Sway (wayland) but sense trying to do very custom things, I've concluded that wayland window managers just aren't for me.