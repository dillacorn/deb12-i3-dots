#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo installing the must-have pre-requisites
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    i3
    fonts-font-awesome
    i3status
    feh
    rofi
    scrot
    dunst
    alacritty
    lxpolkit
    lxappearance
    micro
    nm-tray
    solaar
    blueman
    arandr
    pavucontrol
    pcmanfm
    ffmpeg
    mpv
    cheese
    qimgv
    flameshot
    htop
    btop
    curl
    wget
    git
    gdebi
    flatpak
    cheese
    octave
    cava
    okular
    tigervnc-viewer
    timeshift
    virt-manager
    wireguard
    wireplumber
    gamemode

EOF
)

echo installing the nice-to-have pre-requisites
echo you have 5 seconds to proceed ...
echo or
echo hit Ctrl+C to quit
echo -e "\n"
sleep 6

sudo apt-get install -y tig
