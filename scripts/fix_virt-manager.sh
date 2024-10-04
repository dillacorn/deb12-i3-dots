#!/bin/bash

# Ensure the script is run with sudo
if [ -z "$SUDO_USER" ]; then
    echo "This script must be run with sudo!"
    exit 1
fi

# Ensure libvirt is installed and libvirtd is running
if ! dpkg -l | grep -q libvirt-daemon; then
    echo "libvirt is not installed. Installing it now..."
    apt update
    apt install -y libvirt-daemon-system libvirt-clients
fi

# Ensure libvirtd is enabled and started
systemctl enable --now libvirtd

# Enable and start the default virtual network
virsh net-autostart default
virsh net-start default
