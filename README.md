# dilla.files

Run these commands to download repo
-----------------------------------------------------------------------------------------

cd ~/Downloads

sudo apt install git -y

git clone https://github.com/Dillacorn/dotfiles

New to Linux?
-----------------------------------------------------------------------------------------

folders starting with a DOT ( . ) -> example: ".config" are hidden files.

Recursive copy prefered app settings within "config" to your ".config" in your $HOME directory.

example command:

cd ~/Downloads/dotfiles/config

cp -r SpeedCrunch/ ~/.config/

additionally if you didn't catch it... "~" = $HOME or $home directory (same dir)

for more example commands -> [https://gist.github.com/heobay/8431305](https://github.com/LinkedInLearning/learning-linux-command-line-3005201/blob/e0cfdc8244b804b57c04b5cffc55c0b322122457/commands.md)

Run a script in scripts folder
-----------------------------------------------------------------------------------------

example:

navigate to directory with "cd" command.

cd ~/Downloads/dotfiles/scripts

chmod +x install_my_apps.sh     <- make executable

sudo ./install_my_apps.sh       <- run script

Have an Nvidia GPU?
-----------------------------------------------------------------------------------------

https://github.com/crispyricepc/sway-nvidia for Nvidia GPU fixes for Sway.

or go use i3 wm instead?

My System Specs
-----------------------------------------------------------------------------------------

AMD Ryzen 7 7700

AMD RX 6800 XT

Commands I Run Daily
-----------------------------------------------------------------------------------------

sway

sudo shutdown now

sudo reboot now

cd directory/directory

cd ..

ls

apt list --manual-installed

apt search application_name

sudo apt install application_name

sudo apt update

sudo apt upgrade

sudo apt remove application_name

flatpak list

flatpak search application_name

flatpak install application_id

flatpak update

flatpak uninstall application_name <- ++TAB to list options

clear or CTRL+l

CTRL+a <- goes to beginning of line

CTRL+e <- goes to end of line

CTRL+k <- deletes from cursor to end of line

CTRL+left or CTRL+right <- forward and backward words

Shift+PgUp or Shift+PgDwn <- up and down terminal (faster than scrolling)

rm

rm -r

cp

cp -r

man application_name

micro file_name

for more example commands -> [https://gist.github.com/heobay/8431305](https://github.com/LinkedInLearning/learning-linux-command-line-3005201/blob/e0cfdc8244b804b57c04b5cffc55c0b322122457/commands.md)

My Sway keybinds are atypical for a Sway user
-----------------------------------------------------------------------------------------

My keybinds are suckless DWM inspired. -> https://dwm.suckless.org/

Previously used DWM Flexipatch -> https://github.com/bakkeby/dwm-flexipatch

DWM was my first window manager so some of my keybinds have been reconfigured for easier adoption and transition.

Screw display managers...
-----------------------------------------------------------------------------------------

If there's anything I've experienced the most issues and breaking bugs with it has been the display (login) managers.

TTY for LIFE <- my opinion!

sudo apt remove gdm3 sddm lightdm <- whatever your display manager is remove it..

Login by typing your username and then your password.

execute Sway from TTY: just type "sway"

If you ever have an issue with your current TTY you can make more TTYs with CTRL+ALT+F1 F2 F3 F4 F5 or F6.

No need to thank me thank Linux and say bye to Windows because THIS another reason why Linux is the Goat Operating System of choice!

TL;DR

Want to keep your display manager? Try "ly" -> https://github.com/fairyglade/ly

Converting sway config to i3? Heres how to check for errors
-----------------------------------------------------------------------------------------

I prefer .config directory to store i3 and Sway

command to check errors:

i3 -C -c ~/.config/i3/config

good luck

Wallpapers?
-----------------------------------------------------------------------------------------

https://github.com/AngelJumbo/gruvbox-wallpapers

https://github.com/D3Ext/aesthetic-wallpapers
