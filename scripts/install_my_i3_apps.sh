#!/bin/bash

# Ensure the script is run with sudo
if [ -z "$SUDO_USER" ]; then
    echo "This script must be run with sudo!"
    exit 1
fi

set -eu -o pipefail # fail on error and report it, debug all lines

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

sudo -n true
test $? -eq 0 || { echo -e "${RED}You should have sudo privileges to run this script.${NC}"; exit 1; }

# Prompt for package installation
echo -e "\n${CYAN}Do you want to install Dillacorn's chosen Debian 12 applications? [y/n]${NC}"

# Read a single character without requiring the Enter key
read -n1 -s choice

# Check user input
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo -e "\n${GREEN}Proceeding with installation of Dillacorn's chosen Debian 12 applications...${NC}"
    
    # Update the package list
    echo -e "${CYAN}Updating package list...${NC}"
    apt-get update

    # Non-interactive install to avoid prompts
    echo -e "${CYAN}Installing applications with apt in non-interactive mode${NC}"
    export DEBIAN_FRONTEND=noninteractive

    while read -r p ; do 
        apt-get install -y --fix-missing -o Dpkg::Options::="--force-confnew" "$p" || { echo -e "${RED}Failed to install $p. Error: $?${NC}"; }
    done < <(cat << "EOF"
        i3
        suckless-tools
        fonts-font-awesome
        i3status
        i3lock
        feh
        rofi
        scrot
        slop
        dunst
        lxpolkit
        lxappearance
        micro
        neofetch
        network-manager-gnome
        solaar
        blueman
        arandr
        pavucontrol
        pcmanfm
        ffmpeg
        mpv
        cheese
        libexiv2-27
        qimgv
        flameshot
        htop
        btop
        curl
        wget
        git
        gdebi
        flatpak
        octave
        cava
        okular
        tigervnc-viewer
        timeshift
        virt-manager
        otpclient
        otpclient-cli
        wireguard
        wireplumber
        gamemode
        papirus-icon-theme
        materia-gtk-theme
        comixcursors
        xorg
        xinit
        xserver-xorg-input-libinput
        xautolock
        xclip
        xsel
        pulseaudio-utils
        pipewire-pulse
        bluetooth
        resolvconf
        bridge-utils
        qemu-guest-agent
        dnsmasq
        ebtables
EOF
    )
    
    # Print success message after installation
    echo -e "\n${GREEN}Successfully installed all of Dillacorn's Debian 12 chosen applications!${NC}"
else
    echo -e "\n${YELLOW}Skipping installation of Dillacorn's chosen Debian 12 applications.${NC}"
    exit 0
fi
