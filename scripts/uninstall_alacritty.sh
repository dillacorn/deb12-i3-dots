#!/bin/bash
# requires sudo!

set -e  # Exit on any error

# Remove the Alacritty binary
echo "Removing Alacritty binary..."
rm -f /usr/local/bin/alacritty

# Remove Alacritty from x-terminal-emulator alternatives
echo "Removing Alacritty from x-terminal-emulator alternatives..."
update-alternatives --remove x-terminal-emulator /usr/local/bin/alacritty

# Remove the Alacritty desktop entry
echo "Removing Alacritty desktop entry..."
rm -f /usr/share/applications/Alacritty.desktop
update-desktop-database

# Optional: Remove Rust toolchain and environment if no longer needed
echo "Do you want to uninstall Rust as well? [y/N]"
read -r uninstall_rust
if [[ "$uninstall_rust" =~ ^[Yy]$ ]]; then
    echo "Uninstalling Rust..."
    rustup uninstall
    rm -rf ~/.cargo ~/.rustup
fi

# Done
echo "Alacritty has been uninstalled successfully!"