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

# Define a variable for the home directory
USER_HOME="${SUDO_USER:-$HOME}"
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

# Wait for files to appear
echo "Waiting for configuration files to be available..."
for file in "$CONFIG_DIR/custom_res.sh" "$CONFIG_DIR/i3exit.sh" "$CONFIG_DIR/rotate_configs.sh"; do
    while [ ! -f "$file" ]; do
        echo "Waiting for $file to appear..."
        sleep 1
    done
done

# Make specific files executable after they have been copied
echo "Making scripts executable..."
chmod +x "$CONFIG_DIR/custom_res.sh"
chmod +x "$CONFIG_DIR/i3exit.sh"
chmod +x "$CONFIG_DIR/rotate_configs.sh"

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