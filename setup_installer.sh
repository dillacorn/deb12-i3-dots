#!/bin/bash

#################################################
## "run this script" directions for new users! ##
#################################################

# open a terminal
# sudo apt install git dos2unix -y
# git clone https://github.com/dillacorn/dotfiles
# cd dotfiles
# chmod +x setup_installer.sh
# dos2unix setup_installer.sh
# ./setup_installer.sh
# follow installer

#################################################
## "run this script" directions for new users! ##
#################################################

# Check if the script is run with root privileges, if not, notify user
if [ "$(id -u)" -ne 0 ]; then
    echo "You need to run this script with sudo for some commands."
    echo "For example: sudo ./setup_installer.sh"
    echo "Continue with the script, and manually run any sudo commands as prompted."
fi

# Install git if it's not already installed
apt update
apt install -y git

# Clone the dotfiles repository into the home directory if it doesn't already exist
if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/dillacorn/dotfiles "$HOME/dotfiles"
    if [ $? -ne 0 ]; then
        echo "Failed to clone the dotfiles repository. Exiting."
        exit 1
    fi
else
    echo "dotfiles repository already exists in $HOME."
fi

# Navigate to ~/dotfiles/scripts and make scripts executable
cd ~/dotfiles/scripts || exit
chmod +x *

# Run install_my_i3_apps.sh and install_my_flatpaks.sh before proceeding
echo "Running install_my_i3_apps.sh..."
./install_my_i3_apps.sh
if [ $? -ne 0 ]; then
    echo "install_my_i3_apps.sh failed. Exiting."
    exit 1
fi

echo "Running install_my_flatpaks.sh..."
./install_my_flatpaks.sh
if [ $? -ne 0 ]; then
    echo "install_my_flatpaks.sh failed. Exiting."
    exit 1
fi

# Run other scripts
./fix_virt-manager.sh
./ranger_image_preview.sh

# Copy X11 configuration
echo "You may need to run the following command with sudo:"
echo "cp ~/dotfiles/etc/X11/xinit/xinitrc /etc/X11/xinit/xinitrc"
cp ~/dotfiles/etc/X11/xinit/xinitrc /etc/X11/xinit/xinitrc
if [ $? -ne 0 ]; then
    echo "Failed to copy xinitrc. Exiting."
    exit 1
fi

# Copy other configuration files
echo "Copying Xresources..."
cp ~/dotfiles/Xresources ~/.Xresources
if [ $? -ne 0 ]; then
    echo "Failed to copy Xresources. Exiting."
    exit 1
fi

echo "Copying alacritty config..."
cp -r ~/dotfiles/config/alacritty $HOME/.config/
if [ $? -ne 0 ]; then
    echo "Failed to copy alacritty config. Exiting."
    exit 1
fi

echo "Copying dunst config..."
cp -r ~/dotfiles/config/dunst $HOME/.config/
if [ $? -ne 0 ]; then
    echo "Failed to copy dunst config. Exiting."
    exit 1
fi

echo "Copying i3 config..."
cp -r ~/dotfiles/config/i3 $HOME/.config/
if [ $? -ne 0 ]; then
    echo "Failed to copy i3 config. Exiting."
    exit 1
fi

echo "Copying rofi config..."
cp -r ~/dotfiles/config/rofi $HOME/.config/
if [ $? -ne 0 ]; then
    echo "Failed to copy rofi config. Exiting."
    exit 1
fi

# Make specific files executable after they have been copied
echo "Making scripts executable..."
chmod +x $HOME/.config/custom_res.sh
chmod +x $HOME/.config/i3exit.sh
chmod +x $HOME/.config/rotate_configs.sh

# Navigate to i3 themes and make files executable
cd $HOME/.config/i3/themes || exit
chmod +x *

# Navigate to alacritty and run the theme installation script
cd $HOME/.config/alacritty || exit
chmod +x install_alacritty_themes.sh
./install_alacritty_themes.sh

# Copy .desktop files to local applications directory
echo "You may need to run the following command with sudo:"
echo "cp -r ~/dotfiles/local/share/applications/. $HOME/.local/share/applications/"
cp -r ~/dotfiles/local/share/applications/. $HOME/.local/share/applications/
if [ $? -ne 0 ]; then
    echo "Failed to copy .desktop files. Exiting."
    exit 1
fi

# Set alternatives for editor and terminal emulator
echo "You may need to run the following commands with sudo:"
echo "update-alternatives --set editor /usr/bin/micro"
echo "update-alternatives --set x-terminal-emulator /usr/bin/alacritty"
update-alternatives --set editor /usr/bin/micro
update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# Set default file manager for directories
xdg-mime default thunar.desktop inode/directory application/x-gnome-saved-search

echo "All tasks completed!"
