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

# Install git if it's not already installed
apt update
apt install -y git

# Clone the dotfiles repository into the home directory if it doesn't already exist
if [ ! -d "/home/$SUDO_USER/dotfiles" ]; then
    git clone https://github.com/dillacorn/dotfiles "/home/$SUDO_USER/dotfiles"
    if [ $? -ne 0 ]; then
        echo "Failed to clone the dotfiles repository. Exiting."
        exit 1
    fi
else
    echo "dotfiles repository already exists in /home/$SUDO_USER"
fi

# Navigate to ~/dotfiles/scripts and make scripts executable
cd "/home/$SUDO_USER/dotfiles/scripts" || exit
chmod +x *

# Run install_my_i3_apps.sh and install_my_flatpaks.sh before proceeding
echo "Running install_my_i3_apps.sh..."
./install_my_i3_apps.sh
if [ $? -ne 0 ]; then
    echo "install_my_i3_apps.sh failed. Exiting."
    exit 1
fi

#echo "Running install_my_flatpaks.sh..."
./install_my_flatpaks.sh
if [ $? -ne 0 ]; then
    echo "install_my_flatpaks.sh failed. Exiting."
    exit 1
fi

# Run other scripts
./ranger_image_preview.sh

# Copy X11 configuration
echo "You may need to run the following command with sudo:"
echo "cp /home/$SUDO_USER/dotfiles/etc/X11/xinit/xinitrc /etc/X11/xinit"
cp "/home/$SUDO_USER/dotfiles/etc/X11/xinit/xinitrc" /etc/X11/xinit/
if [ $? -ne 0 ]; then
    echo "Failed to copy xinitrc. Exiting."
    exit 1
fi

# Copy other configuration files
echo "Copying Xresources..."
cp "/home/$SUDO_USER/dotfiles/Xresources" "/home/$SUDO_USER/.Xresources"
if [ $? -ne 0 ]; then
    echo "Failed to copy Xresources. Exiting."
    exit 1
fi

echo "Copying alacritty config..."
cp -r "/home/$SUDO_USER/dotfiles/config/alacritty" "/home/$SUDO_USER/.config"
if [ $? -ne 0 ]; then
    echo "Failed to copy alacritty config. Exiting."
    exit 1
fi

echo "Copying dunst config..."
cp -r "/home/$SUDO_USER/dotfiles/config/dunst" "/home/$SUDO_USER/.config"
if [ $? -ne 0 ]; then
    echo "Failed to copy dunst config. Exiting."
    exit 1
fi

echo "Copying i3 config..."
cp -r "/home/$SUDO_USER/dotfiles/config/i3" "/home/$SUDO_USER/.config"
if [ $? -ne 0 ]; then
    echo "Failed to copy i3 config. Exiting."
    exit 1
fi

echo "Copying rofi config..."
cp -r "/home/$SUDO_USER/dotfiles/config/rofi" "/home/$SUDO_USER/.config"
if [ $? -ne 0 ]; then
    echo "Failed to copy rofi config. Exiting."
    exit 1
fi

# Wait for files to appear
echo "Waiting for configuration files to be available..."
for file in "/home/$SUDO_USER/.config/i3/custom_res.sh" "/home/$SUDO_USER/.config/i3/i3exit.sh" "/home/$SUDO_USER/.config/i3/rotate_configs.sh"; do
    while [ ! -f "$file" ]; do
        echo "Waiting for $file to appear..."
        sleep 1
    done
done

# Make specific files executable after they have been copied
echo "Making scripts executable..."
chmod +x "/home/$SUDO_USER/.config/i3/custom_res.sh"
chmod +x "/home/$SUDO_USER/.config/i3/i3exit.sh"
chmod +x "/home/$SUDO_USER/.config/i3/rotate_configs.sh"

# Navigate to i3 themes and make files executable
cd "/home/$SUDO_USER/.config/i3/themes" || exit
chmod +x *

# Navigate to alacritty and run the theme installation script
cd "/home/$SUDO_USER/.config/alacritty" || exit
chmod +x install_alacritty_themes.sh
./install_alacritty_themes.sh

# Copy .desktop files to local applications directory
echo "You may need to run the following command with sudo:"
echo "cp -r /home/$SUDO_USER/dotfiles/local/share/applications/. /home/$SUDO_USER/.local/share/applications"
cp -r "/home/$SUDO_USER/dotfiles/local/share/applications/." "/home/$SUDO_USER/.local/share/applications"
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

# set permissions
find /home/$SUDO_USER/.config/ -type d -exec chmod 777 {} +
chmod 777 /home/$SUDO_USER/.config/ *

# change ownership
chown -R $USER:$USER /home/$SUDO_USER/.config

echo "All tasks completed!"
