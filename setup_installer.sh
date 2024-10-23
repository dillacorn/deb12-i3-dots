#!/bin/bash
#################################################
##           Installation Instructions         ##
#################################################

# Step 1: Download the repository
# --------------------------------
# Open a terminal and run:
#   sudo apt install git -y
#   git clone https://github.com/dillacorn/deb12-i3-dots

# Step 2: Run the installer
# -------------------------
# Navigate to the deb12-i3-dots directory:
#   cd deb12-i3-dots
# Make the installer executable and run it:
#   chmod +x setup_installer.sh
#   sudo ./setup_installer.sh
# Follow the on-screen instructions.

# Alacritty Notice:
# -----------------
# Alacritty theme changes will NOT work with the version from the Debian Stable repo.
# You can build Alacritty from source using the provided script in this repository.
# Refer to the official installation guide for more details:
# https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu

#################################################
##              End of Instructions            ##
#################################################

# Ensure the script is run with sudo
if [ -z "$SUDO_USER" ]; then
    echo "This script must be run with sudo!"
    exit 1
fi

# Add a warning message for overwriting directories
echo -e "\033[1;31mWARNING: This script will overwrite the following directories:\033[0m"
echo -e "\033[1;33m
- ~/.config/i3
- ~/.config/mc
- ~/.config/alacritty
- ~/.config/rofi
- ~/.config/dunst
- ~/.config/gtk-3.0
- ~/.gtk-2.0
- /etc/X11/xinit/xinitrc
- ~/.Xresources\033[0m"
echo -e "\033[1;31mAre you sure you want to continue? This action CANNOT be undone.\033[0m"
echo -e "\033[1;32mPress 'y' to continue or 'n' to cancel.\033[0m"

# First confirmation
read -n 1 -r first_confirmation
echo

if [[ "$first_confirmation" != "y" && "$first_confirmation" != "Y" ]]; then
    echo -e "\033[1;31mInstallation canceled by user.\033[0m"
    exit 1
fi

# Second confirmation
echo -e "\033[1;31mThis is your last chance! Are you absolutely sure? (y/n)\033[0m"
read -n 1 -r second_confirmation
echo

if [[ "$second_confirmation" != "y" && "$second_confirmation" != "Y" ]]; then
    echo -e "\033[1;31mInstallation canceled by user.\033[0m"
    exit 1
fi

echo -e "\033[1;32mProceeding with the installation...\033[0m"

# Set the home directory of the sudo user
HOME_DIR="/home/$SUDO_USER"

# Check if required directories are present, and create them if not
echo -e "\033[1;34mChecking for required directories...\033[0m"

# List of directories to check/create
required_dirs=(
    "$HOME_DIR/.config"
    "$HOME_DIR/Videos"
    "$HOME_DIR/Pictures/wallpapers"
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

# Clone the deb12-i3-dots repository into the home directory if it doesn't already exist
if [ ! -d "$HOME_DIR/deb12-i3-dots" ]; then
    echo -e "\033[1;34mCloning deb12-i3-dots repository...\033[0m"
    git clone https://github.com/dillacorn/deb12-i3-dots "$HOME_DIR/deb12-i3-dots"
    if [ $? -ne 0 ]; then
        echo -e "\033[1;31mFailed to clone the deb12-i3-dots repository. Exiting.\033[0m"
        exit 1
    fi
    chown -R $SUDO_USER:$SUDO_USER "$HOME_DIR/deb12-i3-dots"
else
    echo -e "\033[1;32mdeb12-i3-dots repository already exists in $HOME_DIR\033[0m"
fi

# Navigate to ~/deb12-i3-dots/scripts and make scripts executable
echo -e "\033[1;34mMaking ~/deb12-i3-dots/scripts executable!\033[0m"
cd "$HOME_DIR/deb12-i3-dots/scripts" || exit
chmod +x *
chown -R $SUDO_USER:$SUDO_USER "$HOME_DIR/deb12-i3-dots/scripts"

# Run install_my_i3_apps.sh and install_my_flatpaks.sh before proceeding
echo -e "\033[1;34mRunning install_my_i3_apps.sh...\033[0m"
./install_my_i3_apps.sh
if [ $? -ne 0 ]; then
    echo -e "\033[1;31minstall_my_i3_apps.sh failed. Exiting.\033[0m"
    exit 1
fi

# Ensure ~/.local/share/applications directory exists
echo -e "\033[1;34mEnsuring ~/.local/share/applications directory exists...\033[0m"
mkdir -p "$HOME_DIR/.local/share/applications"

# Copy .desktop files into ~/.local/share/applications
echo -e "\033[1;34mCopying .desktop files to ~/.local/share/applications...\033[0m"
cp -r "$HOME_DIR/deb12-i3-dots/local/share/applications/." "$HOME_DIR/.local/share/applications"

# Fix ownership and permissions for ~/.local, ~/.local/share, and ~/.local/share/applications
echo -e "\033[1;34mSetting ownership and permissions for ~/.local, ~/.local/share, and ~/.local/share/applications...\033[0m"
chown -R $SUDO_USER:$SUDO_USER "$HOME_DIR/.local"
chmod -R u+rwX "$HOME_DIR/.local"

# Ensure ~/.local and ~/.local/share have correct permissions (including for Xorg)
chmod u+rwx "$HOME_DIR/.local"
chmod u+rwx "$HOME_DIR/.local/share"

echo -e "\033[1;32mOwnership and permissions for ~/.local, ~/.local/share, and ~/.local/share/applications set correctly.\033[0m"

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
cp "$HOME_DIR/deb12-i3-dots/etc/X11/xinit/xinitrc" /etc/X11/xinit/
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy xinitrc. Exiting.\033[0m"
    exit 1
fi

# Copy .Xresources file
echo -e "\033[1;34mCopying .Xresources to $HOME_DIR...\033[0m"
cp "$HOME_DIR/deb12-i3-dots/Xresources" "$HOME_DIR/.Xresources"
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy .Xresources. Exiting.\033[0m"
    exit 1
fi

# Copy other configuration files
config_dirs=("alacritty" "dunst" "i3" "rofi" "mc" "gtk-3.0")

for config in "${config_dirs[@]}"; do
    echo -e "\033[1;32mCopying $config config...\033[0m"
    cp -r "$HOME_DIR/deb12-i3-dots/config/$config" "$HOME_DIR/.config"
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

# Add GTK2 theme and icon settings
echo 'include "'$HOME_DIR'/.gtkrc-2.0.mine"' > "$HOME_DIR/.gtkrc-2.0"
chown $SUDO_USER:$SUDO_USER "$HOME_DIR/.gtkrc-2.0"
chmod 644 "$HOME_DIR/.gtkrc-2.0"

echo -e 'gtk-theme-name="Materia-dark"\ngtk-icon-theme-name="Papirus-Dark"' > "$HOME_DIR/.gtkrc-2.0.mine"
chown $SUDO_USER:$SUDO_USER "$HOME_DIR/.gtkrc-2.0.mine"
chmod 644 "$HOME_DIR/.gtkrc-2.0.mine"

# Copy wallpaper to ~/Pictures/wallpapers directory
echo -e "\033[1;94mCopying wallpaper...\033[0m"
cp "$HOME_DIR/deb12-i3-dots/debianlogo_bw.png" "$HOME_DIR/Pictures/wallpapers/"
if [ $? -ne 0 ]; then
    echo -e "\033[1;31mFailed to copy wallpaper. Exiting.\033[0m"
    exit 1
fi
chown $SUDO_USER:$SUDO_USER "$HOME_DIR/Pictures/wallpapers/debianlogo_bw.png"

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
        
        chmod +x "$HOME_DIR/deb12-i3-dots/scripts/build+install_alacritty.sh"
        "$HOME_DIR/deb12-i3-dots/scripts/build+install_alacritty.sh"
        
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

# Path to the non-root user's .bash_profile
BASH_PROFILE="/home/$SUDO_USER/.bash_profile"

# Check if .bash_profile exists, create if it doesn't
if [ ! -f "$BASH_PROFILE" ]; then
    echo "Creating $BASH_PROFILE..."
    touch "$BASH_PROFILE"
    chown $SUDO_USER:$SUDO_USER "$BASH_PROFILE"
fi

# Add figlet Welcome message using the default font
if ! grep -q "figlet" "$BASH_PROFILE"; then
    echo "Adding figlet welcome to $BASH_PROFILE..."
    echo -e "\nfiglet \"Welcome \$USER!\"" >> "$BASH_PROFILE"
    chown $SUDO_USER:$SUDO_USER "$BASH_PROFILE"
fi

# Add i3-wm instruction
if ! grep -q "To start i3-wm" "$BASH_PROFILE"; then
    echo "Adding i3-wm instruction to $BASH_PROFILE..."
    echo -e "echo -e \"\\033[1;34mTo start i3-wm, type: \\033[1;31mstartx\\033[0m\"" >> "$BASH_PROFILE"
    chown $SUDO_USER:$SUDO_USER "$BASH_PROFILE"
fi

# Add random fun message generator to .bash_profile
if ! grep -q "add_random_fun_message" "$BASH_PROFILE"; then
    echo "Adding random fun message function to $BASH_PROFILE..."

    # Append the function definition to .bash_profile
    echo -e "\n# Function to generate a random fun message" >> "$BASH_PROFILE"
    echo -e "add_random_fun_message() {" >> "$BASH_PROFILE"
    echo -e "  fun_messages=(\"cacafire\" \"cmatrix\" \"aafire\" \"sl\" \"asciiquarium\" \"figlet TTY is cool\")" >> "$BASH_PROFILE"
    echo -e "  RANDOM_FUN_MESSAGE=\${fun_messages[\$RANDOM % \${#fun_messages[@]}]}" >> "$BASH_PROFILE"
    echo -e "  echo -e \"\\033[1;33mFor some fun, try running \\033[1;31m\$RANDOM_FUN_MESSAGE\\033[1;33m !\\033[0m\"" >> "$BASH_PROFILE"
    echo -e "}" >> "$BASH_PROFILE"

    # Append the function call to .bash_profile so it runs on every login
    echo -e "\n# Call the random fun message function on login" >> "$BASH_PROFILE"
    echo -e "add_random_fun_message" >> "$BASH_PROFILE"

    chown $SUDO_USER:$SUDO_USER "$BASH_PROFILE"
fi

echo "Changes have been applied to $BASH_PROFILE."

# Notify user that the setup is complete and the system will reboot
echo -e "\033[1;34mSetup complete! Rebooting the system to finalize changes...\033[0m"
sleep 5

# Reboot the system
reboot
