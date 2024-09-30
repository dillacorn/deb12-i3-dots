#!/bin/bash
# requires sudo!

#################################################
## "run this script" directions for new users! ##
#################################################

################################
## !DOWNLOAD REPO DIRECTIONS! ##
################################

# open a terminal
# sudo apt install git -y
# git clone https://github.com/dillacorn/i3-dots

################################
## !RUN INSTALLER DIRECTIONS! ##
################################

# cd i3-dots
# chmod +x setup_installer.sh
# sudo ./setup_installer.sh
# follow installer

########################
## !ALACRITTY NOTICE! ##
########################

# alacritty ~theme changing~ WILL NOT work **(YET)** from Debian Stable repo.
# I suggest building alacritty from source.
# I've provided a script that gives you the option to install alacritty from source! (see line #171-200)
# https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu

#################################################
##              end of directions              ##
#################################################

# Ensure the script is run with sudo
if [ -z "$SUDO_USER" ]; then
    echo "This script must be run with sudo!"
    exit 1
fi

# Set the home directory of the sudo user
HOME_DIR="/home/$SUDO_USER"

# Check if required directories are present, and create them if not
echo -e "\033[1;34mChecking for required directories...\033[0m"

# List of directories to check/create
required_dirs=(
    "$HOME_DIR/.config"
    "$HOME_DIR/Videos"
    "$HOME_DIR/Pictures"
    "$HOME_DIR/Documents"
    "$HOME_DIR/Downloads"
)

# Loop through and create any missing directories
for dir in "${required_dirs[@]}"; do
    if [ ! -d "$dir" ]; then
        echo -e "\033[1;33mCreating missing directory: $dir\033[0m"
        mkdir -p "$dir"
        chown $SUDO_USER:$SUDO_USER "$dir"
    else
        echo -e "\033[1;32mDirectory already exists: $dir\033[0m"
    fi
done

# Install git if it's not already installed
echo -e "\033[1;34mUpdating package list and installing git...\033[0m"
apt update
apt install -y git

# Clone the i3-dots repository into the home directory if it doesn't already exist
if [ ! -d "$HOME_DIR/i3-dots" ]; then
    echo -e "\033[1;34mCloning i3-dots repository...\033[0m"
    git clone https://github.com/dillacorn/i3-dots "$HOME_DIR/i3-dots"
    if [ $? -ne 0 ]; then
        echo -e "\033[1;31mFailed to clone the i3-dots repository. Exiting.\033[0m"
        exit 1
    fi
    chown -R $SUDO_USER:$SUDO_USER "$HOME_DIR/i3-dots"
else
    echo -e "\033[1;32mi3-dots repository already exists in $HOME_DIR\033[0m"
fi

# Navigate to ~/i3-dots/scripts and make scripts executable
echo -e "\033[1;34mMaking ~/i3-dots/scripts executable!\033[0m"
cd "$HOME_DIR/i3-dots/scripts" || exit
chmod +x *
chown -R $SUDO_USER:$SUDO_USER "$HOME_DIR/i3-dots/scripts"

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

echo -e "\033[1;34mRunning install_micro_themes.sh...\033[0m"
./install_micro_themes.sh
if [ $? -ne 0 ]; then
    echo -e "\033[1;31minstall_micro_themes.sh failed. Exiting.\033[0m"
    exit 1
fi

# Copy X11 configuration
echo -e "\033[1;34mCopying X11 config...\033[0m"
mkdir -p /etc/X11/xinit
cp "$HOME_DIR/i3-dots/etc/X11/xinit/xinitrc" /etc/X11/xinit/
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy xinitrc. Exiting.\033[0m"
    exit 1
fi

# Copy other configuration files
config_dirs=("alacritty" "dunst" "i3" "rofi" "mc")

for config in "${config_dirs[@]}"; do
    echo -e "\033[1;32mCopying $config config...\033[0m"
    cp -r "$HOME_DIR/i3-dots/config/$config" "$HOME_DIR/.config"
    if [ $? -ne 0 ]; then
        echo -e "\033[1;31mFailed to copy $config config. Exiting.\033[0m"
        exit 1
    fi
    chown -R $SUDO_USER:$SUDO_USER "$HOME_DIR/.config/$config"
done

# Set permissions for .config
echo -e "\033[1;34mSetting permissions on configuration files and directories...\033[0m"
find "$HOME_DIR/.config/" -type d -exec chmod 755 {} +
find "$HOME_DIR/.config/" -type f -exec chmod 644 {} +

# Make specific i3-related scripts executable (recursively)
echo -e "\033[1;34mMaking i3-related scripts executable...\033[0m"
find "$HOME_DIR/.config/i3/scripts" -type f -exec chmod +x {} +

# Make all files in the themes folder executable (recursively)
echo -e "\033[1;34mMaking all files in $HOME_DIR/.config/i3/themes executable...\033[0m"
find "$HOME_DIR/.config/i3/themes" -type f -exec chmod +x {} +

# Navigate to alacritty and make the installation script executable
echo -e "\033[1;34mRunning install_alacritty_themes.sh...\033[0m"
cd "$HOME_DIR/.config/alacritty" || exit
chmod 755 install_alacritty_themes.sh
./install_alacritty_themes.sh

# Set alternatives for editor
echo -e "\033[1;94mSetting micro as default editor...\033[0m"
update-alternatives --set editor /usr/bin/micro

# Set default file manager for directories
echo -e "\033[1;94mSetting pcmanfm as default GUI file manager...\033[0m"
xdg-mime default pcmanfm.desktop inode/directory application/x-gnome-saved-search

# Change ownership of all files in .config to the sudo user
echo -e "\033[1;32mConverting .config file ownership...\033[0m"
chown -R $SUDO_USER:$SUDO_USER "$HOME_DIR/.config"

# Ask the user if they want to run the build+install_alacritty.sh script
echo -e "\033[1;96mDo you want to build and install Alacritty from source? (y/n)\033[0m"
read -n 1 -r response
echo

if [[ "$response" == "y" || "$response" == "Y" ]]; then
    echo -e "\033[1;96mAre you sure? This will build Alacritty from source. (y/n)\033[0m"
    read -n 1 -r confirmation
    echo

    if [[ "$confirmation" == "y" || "$confirmation" == "Y" ]]; then
        echo "Running the Alacritty build and install script..."
        
        chmod +x "$HOME_DIR/i3-dots/scripts/build+install_alacritty.sh"
        "$HOME_DIR/i3-dots/scripts/build+install_alacritty.sh"
        
        if [ $? -ne 0 ]; then
            echo "Failed to run build+install_alacritty.sh. Exiting."
            exit 1
        else
            update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
            update-alternatives --set x-terminal-emulator /usr/local/bin/alacritty
        fi
    else
        echo "Alacritty build and install canceled."
    fi
else
    echo "Skipping the Alacritty build and install script."
fi

echo -e "\e[32mAll tasks completed!\e[0m"
echo -e "\e[35mGo login to i3-wm!\e[0m"
