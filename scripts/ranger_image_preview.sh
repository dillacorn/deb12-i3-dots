#!/bin/bash
# requires sudo!

# populate ~/.config
ranger --copy-config=all

# enable image previews in ranger
sudo sed -i 's/set preview_images false/set preview_images true/' "/etc/ranger/config/rc.conf"
