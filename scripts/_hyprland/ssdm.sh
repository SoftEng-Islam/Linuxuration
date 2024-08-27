#!/bin/bash
# ----------------------------------------------------- #
# https://gitlab.com/Matt.Jolly/sddm-eucalyptus-drop/
# ----------------------------------------------------- #
# Install SSDM With Login Screen Theme
# ----------------------------------------------------- #
sudo pacman -S --noconfirm sddm
cd ~/Downloads && git clone https://gitlab.com/Matt.Jolly/sddm-eucalyptus-drop.git
cd sddm-eucalyptus-drop
sudo cp -r eucalyptus-drop /usr/share/sddm/themes/

sudo tee /etc/sddm.conf <<EOF >/dev/null
[Theme]
Current=eucalyptus-drop
EOF

# you must restart sddm to load the new themes:
#sudo systemctl restart sddm

# To Preview The Login Screen run:
# sddm-greeter --test-mode --theme /usr/share/sddm/themes/eucalyptus-drop