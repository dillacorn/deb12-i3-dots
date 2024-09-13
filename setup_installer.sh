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
# I've provided a script that gives you the option to install alacritty from source! (see line #171-200)
# https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu

#################################################
##              end of directions              ##
#################################################

# Install git if it's not already installed
echo -e "\033[1;34mUpdating package list and installing git...\033[0m"
apt update
apt install -y git

# Clone the dotfiles repository into the home directory if it doesn't already exist
if [ ! -d "/home/$SUDO_USER/dotfiles" ]; then
    echo -e "\033[1;34mCloning dotfiles repository...\033[0m"
    git clone https://github.com/dillacorn/dotfiles "/home/$SUDO_USER/dotfiles"
    if [ $? -ne 0 ]; then
        echo -e "\033[1;31mFailed to clone the dotfiles repository. Exiting.\033[0m"
        exit 1
    fi
else
    echo -e "\033[1;32mdotfiles repository already exists in /home/$SUDO_USER\033[0m"
fi

# Navigate to ~/dotfiles/scripts and make scripts executable
echo -e "\033[1;34mMaking ~/dotfiles/scripts executable!\033[0m"
cd "/home/$SUDO_USER/dotfiles/scripts" || exit
chmod +x *

# Run install_my_i3_apps.sh and install_my_flatpaks.sh before proceeding
echo -e "\033[1;34mRunning install_my_i3_apps.sh...\033[0m"
./install_my_i3_apps.sh
if [ $? -ne 0 ]; then
    echo -e "\033[1;31minstall_my_i3_apps.sh failed. Exiting.\033[0m"
    exit 1
fi

echo -e "\033[1;34mRunning install_my_flatpaks.sh...\033[0m"
./install_my_flatpaks.sh
if [ $? -ne 0 ]; then
    echo -e "\033[1;31minstall_my_flatpaks.sh failed. Exiting.\033[0m"
    exit 1
fi

echo -e "\033[1;34mRunning ranger_image_preview.sh...\033[0m"
./ranger_image_preview.sh
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mranger_image_preview.sh failed. Exiting.\033[0m"
    exit 1
fi

echo -e "\033[1;34mRunning install_micro_themes.sh...\033[0m"
./install_micro_themes.sh
if [ $? -ne 0 ]; then
    echo -e "\033[1;31minstall_micro_themes.sh failed. Exiting.\033[0m"
    exit 1
fi

# Copy X11 configuration
echo -e "\033[1;34mCopying X11 config...\033[0m"
cp "/home/$SUDO_USER/dotfiles/etc/X11/xinit/xinitrc" /etc/X11/xinit/
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy xinitrc. Exiting.\033[0m"
    exit 1
fi

# Copy other configuration files
echo -e "\033[1;34mCopying Xresources...\033[0m"
cp "/home/$SUDO_USER/dotfiles/Xresources" "/home/$SUDO_USER/.Xresources"
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy Xresources. Exiting.\033[0m"
    exit 1
fi

echo -e "\033[1;32mCopying alacritty config...\033[0m"
cp -r "/home/$SUDO_USER/dotfiles/config/alacritty" "/home/$SUDO_USER/.config"
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy alacritty config. Exiting.\033[0m"
    exit 1
fi

echo -e "\033[1;32mCopying dunst config...\033[0m"
cp -r "/home/$SUDO_USER/dotfiles/config/dunst" "/home/$SUDO_USER/.config"
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy dunst config. Exiting.\033[0m"
    exit 1
fi

echo -e "\033[1;32mCopying i3 config...\033[0m"
cp -r "/home/$SUDO_USER/dotfiles/config/i3" "/home/$SUDO_USER/.config"
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy i3 config. Exiting.\033[0m"
    exit 1
fi

echo -e "\033[1;32mCopying rofi config...\033[0m"
cp -r "/home/$SUDO_USER/dotfiles/config/rofi" "/home/$SUDO_USER/.config"
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy rofi config. Exiting.\033[0m"
    exit 1
fi

# Set directory permissions
echo -e "\033[1;34mSetting permissions on configuration files and directories...\033[0m"
find /home/$SUDO_USER/.config/ -type d -exec chmod 755 {} +
find /home/$SUDO_USER/.config/ -type f -exec chmod 644 {} +

# Make specific i3-related scripts executable after setting general permissions
echo -e "\033[1;34mMaking i3-related scripts executable...\033[0m"
chmod 755 /home/$SUDO_USER/.config/i3/scripts/*

# Make all files in the themes folder executable
echo -e "\033[1;34mMaking all files in /home/$SUDO_USER/.config/i3/themes executable...\033[0m"
chmod 755 /home/$SUDO_USER/.config/i3/themes/*

# Navigate to alacritty and make the installation script executable
echo -e "\033[1;34mRunning install_alacritty_themes.sh...\033[0m"
cd "/home/$SUDO_USER/.config/alacritty" || exit
chmod 755 install_alacritty_themes.sh
./install_alacritty_themes.sh

# Copy .desktop files to local applications directory
echo -e "\033[1;34mCopying .desktop for app launchers...\033[0m"
cp -r "/home/$SUDO_USER/dotfiles/local/share/applications/." "/home/$SUDO_USER/.local/share/applications"
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy .desktop files. Exiting.\033[0m"
    exit 1
fi

# Set alternatives for editor
echo -e "\033[1;94mSetting micro as default editor...\033[0m"
update-alternatives --set editor /usr/bin/micro

# Set default file manager for directories
echo -e "\033[1;94mSetting pcmanfm as default GUI file manager...\033[0m"
xdg-mime default pcmanfm.desktop inode/directory application/x-gnome-saved-search

# Change ownership of all files in .config to the sudo user
echo -e "\033[1;32mConverting .config file ownership...\033[0m"
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config

# Ask the user if they want to run the build+install_alacritty.sh script (in bright cyan text)
echo -e "\033[1;96mDo you want to build and install Alacritty from source? (yes/no)\033[0m"
read -r response

if [[ "$response" == "yes" || "$response" == "y" ]]; then
    # Ask the user for confirmation (in blue text)
    echo -e "\033[1;96mAre you sure? This will build Alacritty from source. (yes/no)\033[0m"
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
