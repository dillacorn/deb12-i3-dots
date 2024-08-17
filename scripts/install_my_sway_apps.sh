#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo installing the must-have pre-requisites
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    sway
    swaybg
    swayidle
    swaylock
    wlogout
    lxpolkit
    alacritty
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    arandr
    wl-clipboard
    wf-recorder
    fonts-font-awesome
    pavucontrol
    waybar
    mako-notifier
    micro
    wofi
    qimgv
    mpv
    cheese
    grimshot
    flameshot
    htop
    curl
    wget
    git
    gdebi
    flatpak
    cheese
    speedcrunch
    cava
    chromium
    okular
    nm-tray
    blueman
    ffmpeg
    pcmanfm
    gcolor3
    simplescreenrecorder
    timeshift
    tigervnc-viewer
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
