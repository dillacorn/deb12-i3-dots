#!/bin/bash
# requires sudo!

# Ensure the script is run with sudo
if [ -z "$SUDO_USER" ]; then
    echo "This script must be run with sudo!"
    exit 1
fi

set -e  # Exit on any error

# Remove the Alacritty binary
echo "Removing Alacritty binary..."
sudo rm -f /usr/local/bin/alacritty

# Remove Alacritty from x-terminal-emulator alternatives
echo "Removing Alacritty from x-terminal-emulator alternatives..."
sudo update-alternatives --remove x-terminal-emulator /usr/local/bin/alacritty

# Remove the Alacritty desktop entry
echo "Removing Alacritty desktop entry..."
sudo rm -f /usr/share/applications/Alacritty.desktop
sudo update-desktop-database

# Optional: Remove Rust toolchain and environment if no longer needed
echo "Do you want to uninstall Rust as well? [y/N]"
read -r uninstall_rust
if [[ "$uninstall_rust" =~ ^[Yy]$ ]]; then
    echo "Uninstalling Rust..."
    # Remove Rust installation and configuration directories for the invoking user
    sudo rm -rf "/home/$SUDO_USER/.cargo" "/home/$SUDO_USER/.rustup"

    # Optionally, remove Rust paths from the user's shell configuration
    shell_config="/home/$SUDO_USER/.bashrc"  # Adjust this if using another shell like .zshrc
    if grep -q 'export PATH="$HOME/.cargo/bin:$PATH"' "$shell_config"; then
        echo "Removing Rust path from $shell_config..."
        sed -i '/export PATH="$HOME\/.cargo\/bin:$PATH"/d' "$shell_config"
    fi
    echo "Rust has been uninstalled."
fi

# Done
echo "Alacritty and (optionally) Rust have been uninstalled successfully!"
