#!/bin/bash

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

# Make specific files executable
chmod +x ~/.config/custom_res.sh
chmod +x ~/.config/i3exit.sh
chmod +x ~/.config/rotate_configs.sh

# Navigate to i3 themes and make files executable
cd ~/.config/i3/themes || exit
chmod +x *

# Navigate to alacritty and run the theme installation script
cd ~/.config/alacritty || exit
chmod +x install_alacritty_themes.sh
./install_alacritty_themes.sh

# Copy .desktop files to local applications directory
cp -r ~/dotfiles/local/share/applications/. ~/.local/share/applications/
if [ $? -ne 0 ]; then
    echo "Failed to copy .desktop files. Exiting."
    exit 1
fi

# Set alternatives for editor and terminal emulator
update-alternatives --set editor /usr/bin/micro
update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# Set default file manager for directories
xdg-mime default thunar.desktop inode/directory application/x-gnome-saved-search

echo "All tasks completed!"
