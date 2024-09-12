#!/bin/bash

#################################################
## "run this script" directions for new users! ##
#################################################

################################
## !DOWNLOAD REPO DIRECTIONS! ##
################################

# open a terminal
# sudo apt install git -y
# git clone https://github.com/dillacorn/dotfiles

################################
## !RUN INSTALLER DIRECTIONS! ##
################################

# cd dotfiles
# chmod +x setup_installer.sh
# sudo ./setup_installer.sh
# follow installer

########################
## !ALACRITTY NOTICE! ##
########################

# alacritty theme changing WILL NOT work **(YET)** from Debian Stable repo.
# I suggest building alacritty from source.
# I've provided a script that gives you the option to install alacritty from source! (see line #177-196)
# https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu

#################################################
##              end of directions              ##
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
echo "Making ~/dotfiles/scripts executable!"
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
echo "Running install_my_flatpaks.sh..."
./install_my_flatpaks.sh
if [ $? -ne 0 ]; then
    echo "install_my_flatpaks.sh failed. Exiting."
    exit 1
fi

#echo "Running ranger_image_preview.sh"
echo "Running ranger_image_preview.sh..."
./ranger_image_preview.sh
if [ $? -ne 0 ]; then
    echo "ranger_image_preview.sh failed. Exiting."
    exit 1
fi

#echo "Running install_micro_theme.sh"
echo "Running install_micro_themes.sh..."
./install_micro_themes.sh
if [ $? -ne 0 ]; then
    echo "install_micro_themes.sh failed. Exiting."
    exit 1
fi

# Copy X11 configuration
echo "Copying X11 config..."
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

# Set directory permissions
echo "Setting permissions on configuration files and directories..."
find /home/$SUDO_USER/.config/ -type d -exec chmod 755 {} +
find /home/$SUDO_USER/.config/ -type f -exec chmod 644 {} +

# Make specific i3-related scripts executable after setting general permissions
echo "Making i3-related scripts executable..."
chmod 755 /home/$SUDO_USER/.config/i3/scripts/*

# Make all files in the themes folder executable
echo "Making all files in /home/$SUDO_USER/.config/i3/themes executable..."
chmod 755 /home/$SUDO_USER/.config/i3/themes/*

# Navigate to alacritty and make the installation script executable
cd "/home/$SUDO_USER/.config/alacritty" || exit
chmod 755 install_alacritty_themes.sh
./install_alacritty_themes.sh

# Copy .desktop files to local applications directory
echo "Copying .desktop for app launchers to see!"
echo "cp -r /home/$SUDO_USER/dotfiles/local/share/applications/. /home/$SUDO_USER/.local/share/applications"
cp -r "/home/$SUDO_USER/dotfiles/local/share/applications/." "/home/$SUDO_USER/.local/share/applications"
if [ $? -ne 0 ]; then
    echo "Failed to copy .desktop files. Exiting."
    exit 1
fi

# Set alternatives for editor
echo "Setting micro as default editor!"
echo "update-alternatives --set editor /usr/bin/micro"
update-alternatives --set editor /usr/bin/micro

# Set default file manager for directories
echo "Setting pcmanfm as default GUI file manager!"
echo "xdg-mime default pcmanfm.desktop inode/directory application/x-gnome-saved-search"
xdg-mime default pcmanfm.desktop inode/directory application/x-gnome-saved-search

# Change ownership of all files in .config to the sudo user
echo "Converting .config file ownership!"
echo "chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config"
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config

# Ask the user if they want to run the build+install_alacritty.sh script (in blue text)
echo -e "\e[94mDo you want to build and install Alacritty from source? (yes/no)\e[0m"
read -r response

if [[ "$response" == "yes" || "$response" == "y" ]]; then
    # Ask the user for confirmation (in blue text)
    echo -e "\e[94mAre you sure? This will build Alacritty from source. (yes/no)\e[0m"
    read -r confirmation

    if [[ "$confirmation" == "yes" || "$confirmation" == "y" ]]; then
        echo "Running the Alacritty build and install script..."
        
        # Ensure the script is executable
        chmod +x "/home/$SUDO_USER/dotfiles/scripts/build+install_alacritty.sh"
        
        # Run the script
        /home/$SUDO_USER/dotfiles/scripts/build+install_alacritty.sh
        
        if [ $? -ne 0 ]; then
            echo "Failed to run build+install_alacritty.sh. Exiting."
            exit 1
        else
            echo "Alacritty has been successfully installed!"
        fi
    else
        echo "Alacritty build and install canceled."
    fi
else
    echo "Skipping the Alacritty build and install script."
fi

echo -e "\e[32mAll tasks completed!\e[0m"
echo -e "\e[35mGo login to i3-wm!\e[0m"
