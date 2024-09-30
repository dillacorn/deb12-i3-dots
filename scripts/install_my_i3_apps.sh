#!/bin/bash
# requires sudo!

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
echo -e "\n${CYAN}Do you want to install Dillacorn's chosen Debian applications? [y/n]${NC}"

# Read a single character without requiring the Enter key
read -n1 -s choice

# Check user input
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo -e "\n${GREEN}Proceeding with installation of Dillacorn's chosen Debian applications...${NC}"
    
    # Update the package list
    echo -e "${CYAN}Updating package list...${NC}"
    sudo apt-get update

    echo -e "${CYAN}Installing applications with apt${NC}"
    while read -r p ; do 
        sudo apt-get install -y --fix-missing "$p" || { echo -e "${RED}Failed to install $p. Error: $?${NC}"; }
    done < <(cat << "EOF"
        i3
        fonts-font-awesome
        i3status
        feh
        rofi
        scrot
        slop
        dunst
        ueberzug
        mc
        lxpolkit
        lxappearance
        micro
        neofetch
        nm-tray
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
        xorg
        pipewire-pulse
        bluetooth
EOF
    )
else
    echo -e "\n${YELLOW}Skipping installation of Dillacorn's chosen Debian applications.${NC}"
    exit 0
fi
