#!/bin/bash

set -e  # Exit on any error

# Update and install dependencies
echo "Updating package lists and installing dependencies..."
sudo apt update
sudo apt install -y \
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
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Source the Rust environment
export PATH="$HOME/.cargo/bin:$PATH"
source "$HOME/.cargo/env"

# Install Rust toolchain
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
sudo cp target/release/alacritty /usr/local/bin

# Optional: Install the Alacritty desktop entry
echo "Installing Alacritty desktop entry..."
cp extra/linux/Alacritty.desktop /usr/share/applications
update-desktop-database

# Clean up
echo "Cleaning up..."
cd ..
rm -rf alacritty

# Done
echo "Alacritty has been built and installed successfully!"
