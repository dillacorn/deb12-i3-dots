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
# sudo ./setup_installer.sh
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

# Define the home directory for the user
USER_HOME="/home/dillon"
DOTFILES_DIR="$USER_HOME/dotfiles"
CONFIG_DIR="$USER_HOME/.config"
LOCAL_SHARE_DIR="$USER_HOME/.local/share"

# Install git if it's not already installed
apt update
apt install -y git

# Clone the dotfiles repository into the home directory if it doesn't already exist
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone https://github.com/dillacorn/dotfiles "$DOTFILES_DIR"
    if [ $? -ne 0 ]; then
        echo "Failed to clone the dotfiles repository. Exiting."
        exit 1
    fi
else
    echo "dotfiles repository already exists in $USER_HOME."
fi

# Navigate to ~/dotfiles/scripts and make scripts executable
cd "$DOTFILES_DIR/scripts" || exit
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
echo "cp $DOTFILES_DIR/etc/X11/xinit/xinitrc /etc/X11/xinit/xinitrc"
cp "$DOTFILES_DIR/etc/X11/xinit/xinitrc" /etc/X11/xinit/xinitrc
if [ $? -ne 0 ]; then
    echo "Failed to copy xinitrc. Exiting."
    exit 1
fi

# Copy other configuration files
echo "Copying Xresources..."
cp "$DOTFILES_DIR/Xresources" "$USER_HOME/.Xresources"
if [ $? -ne 0 ]; then
    echo "Failed to copy Xresources. Exiting."
    exit 1
fi

echo "Copying alacritty config..."
cp -r "$DOTFILES_DIR/config/alacritty" "$CONFIG_DIR/"
if [ $? -ne 0 ]; then
    echo "Failed to copy alacritty config. Exiting."
    exit 1
fi

echo "Copying dunst config..."
cp -r "$DOTFILES_DIR/config/dunst" "$CONFIG_DIR/"
if [ $? -ne 0 ]; then
    echo "Failed to copy dunst config. Exiting."
    exit 1
fi

echo "Copying i3 config..."
cp -r "$DOTFILES_DIR/config/i3" "$CONFIG_DIR/"
if [ $? -ne 0 ]; then
    echo "Failed to copy i3 config. Exiting."
    exit 1
fi

echo "Copying rofi config..."
cp -r "$DOTFILES_DIR/config/rofi" "$CONFIG_DIR/"
if [ $? -ne 0 ]; then
    echo "Failed to copy rofi config. Exiting."
    exit 1
fi

# Wait for a moment to ensure files are copied
sleep 2

# Make specific files executable after they have been copied
echo "Making scripts executable..."
if [ -f "$CONFIG_DIR/custom_res.sh" ]; then
    chmod +x "$CONFIG_DIR/custom_res.sh"
else
    echo "File $CONFIG_DIR/custom_res.sh does not exist."
fi

if [ -f "$CONFIG_DIR/i3exit.sh" ]; then
    chmod +x "$CONFIG_DIR/i3exit.sh"
else
    echo "File $CONFIG_DIR/i3exit.sh does not exist."
fi

if [ -f "$CONFIG_DIR/rotate_configs.sh" ]; then
    chmod +x "$CONFIG_DIR/rotate_configs.sh"
else
    echo "File $CONFIG_DIR/rotate_configs.sh does not exist."
fi

# Navigate to i3 themes and make files executable
cd "$CONFIG_DIR/i3/themes" || exit
chmod +x *

# Navigate to alacritty and run the theme installation script
cd "$CONFIG_DIR/alacritty" || exit
chmod +x install_alacritty_themes.sh
./install_alacritty_themes.sh

# Copy .desktop files to local applications directory
echo "You may need to run the following command with sudo:"
echo "cp -r $DOTFILES_DIR/local/share/applications/. $LOCAL_SHARE_DIR/applications/"
cp -r "$DOTFILES_DIR/local/share/applications/." "$LOCAL_SHARE_DIR/applications/"
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
