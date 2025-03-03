#!/usr/bin/env bash
# This script MIGHT require sudo IF flatpak isn't already installed!

# Flatpak installation and setup script

# Color Variables
CYAN_B='\033[1;96m'
YELLOW='\033[0;93m'
RED_B='\033[1;31m'
RESET='\033[0m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'

# Remote origin to use for installations
flatpak_origin='flathub'

# List of desktop apps to be installed (specified by app ID)
flatpak_apps=(
  'com.github.IsmaelMartinez.teams_for_linux'             # Teams Work Client
  'dev.vencord.Vesktop'                                   # Discord Client
  'org.telegram.desktop'                                  # Telegram Client
  'com.spotify.Client'                                    # Music streaming
  'com.valvesoftware.Steam'                               # Steam Game Client
  'net.davidotek.pupgui2'                                 # Install 3D party Proton Versions
  'com.moonlight_stream.Moonlight'                        # Game/Remote RDP VNC Client
  'io.itch.itch'                                          # Install and play itch.io games
  'com.heroicgameslauncher.hgl'                           # Game Launcher
  'io.github.hrkfdn.ncspot'                               # Spotify TUI Client
  'com.ultimaker.cura'                                    # 3D slicing
  'com.obsproject.Studio'                                 # Video recording/streaming
  'fr.handbrake.ghb'                                      # Video transcoder
  'nl.hjdskes.gcolor3'                                    # Color picker
  'org.audacityteam.Audacity'                             # Sound editor
  'org.flameshot.Flameshot'                               # Screenshot tool
  'org.kde.krita'                                         # Picture editor
  'org.shotcut.Shotcut'                                   # Video editor
  'org.localsend.localsend_app'                           # Send/Receive Files
  'org.bleachbit.BleachBit'                               # Disk cleaner and log remover
  'it.mijorus.smile'                                      # Emoji picker
  'org.filezillaproject.Filezilla'                        # FTP Client
  'com.github.tchx84.Flatseal'                            # Modify Flatpak Permissions
  'net.mullvad.MullvadBrowser'                            # Firefox Privacy Browser
  'io.github.ungoogled_software.ungoogled_chromium'       # Degoogled Chromium-based browser
  'com.rustdesk.RustDesk'                                 # Teamviewer replacement
  'dev.deedles.Trayscale'                                 # Tailscale GUI unofficial client ~ tailscale needs to be installed seperately
)

# Check if Flatpak is installed; if not, install it via apt
if ! command -v flatpak &> /dev/null; then
  echo -e "${PURPLE}Flatpak is not installed. Installing Flatpak...${RESET}"
  sudo apt update && sudo apt install -y flatpak
fi

# Prompt the user to proceed with installation
echo -e "${CYAN_B}Would you like to install Dillacorn's chosen Flatpak applications? (y/n)${RESET}"
read -n 1 -r REPLY
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${YELLOW}Flatpak setup and install canceled by the user...${RESET}"
  exit 0
fi

# Add Flathub repository if not already present
echo -e "${GREEN}Adding Flathub repository...${RESET}"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Update currently installed Flatpak apps
echo -e "${GREEN}Updating installed Flatpak apps...${RESET}"
sudo flatpak update -y

# Install apps from the list
echo -e "${GREEN}Installing selected Flatpak apps...${RESET}"
for app in "${flatpak_apps[@]}"; do
  if ! flatpak list --app | grep -q "${app}"; then
    echo -e "${GREEN}Installing ${app}...${RESET}"
    sudo flatpak install -y "$flatpak_origin" "$app"
  else
    echo -e "${YELLOW}${app} is already installed. Skipping...${RESET}"
  fi
done

echo -e "${PURPLE}Flatpak setup and installation complete.${RESET}"
