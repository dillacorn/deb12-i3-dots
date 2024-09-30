#!/bin/bash
# requires sudo!

# Ensure the script is run with sudo
if [ -z "$SUDO_USER" ]; then
    echo "This script must be run with sudo!"
    exit 1
fi

virsh net-autostart default
virsh net-start default
