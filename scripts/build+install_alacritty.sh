#!/bin/bash
# requires sudo!

# Ensure the script is run with sudo
if [ -z "$SUDO_USER" ]; then
    echo "This script must be run with sudo!"
    exit 1
fi

set -e  # Exit on any error

# Update and install dependencies
echo "Updating package lists and installing dependencies..."
apt update
apt install -y \
    python3 \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    git \
    build-essential \
    cmake \
    libssl-dev \
    libx11-xcb-dev \
    libxkbcommon-x11-dev \
    libxcb-randr0-dev \
    libxcb-cursor-dev \
    curl \
    pkg-config

# Install Rust using rustup
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source the Rust environment to ensure we can run rustup and cargo
echo "Sourcing Rust environment..."
source "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"

# Install Rust toolchain
echo "Installing stable Rust toolchain..."
rustup install stable
rustup default stable

# Ensure Rust is up-to-date
echo "Updating Rust..."
rustup update

# Clone the Alacritty repository
echo "Cloning the Alacritty repository..."
git clone https://github.com/alacritty/alacritty.git
cd alacritty

# Build Alacritty
echo "Building Alacritty..."
cargo build --release

# Install Alacritty
echo "Installing Alacritty..."
cp target/release/alacritty /usr/local/bin

# Optional: Install the Alacritty desktop entry
echo "Installing Alacritty desktop entry..."
cp extra/linux/Alacritty.desktop /usr/share/applications

# Clean up
echo "Cleaning up..."
cd ..
rm -rf alacritty

# Add Alacritty to x-terminal-emulator and set priority above the rest
echo "Setting Alacritty as the default terminal emulator..."
update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50

# Set Alacritty as default terminal
update-alternatives --set x-terminal-emulator /usr/local/bin/alacritty

# Done
echo "Alacritty has been built and installed successfully!"
