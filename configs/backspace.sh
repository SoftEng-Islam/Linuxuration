#!/bin/bash
# Here a script to make file explorer in Linux (nau) support 'back' to prev path by clicking on backspace.

# Install The Dependencies
cd ~/Downloads/
git clone https://github.com/alt-gnome-team/nautilus-backspace.git
cd nautilus-backspace
sudo pacman -Sy python-nautilus
sudo make
sudo make schemas


# Change of combination
# gsettings set io.github.alt-gnome-team.nautilus-backspace back '<Alt>Down'
# Return to the default value
# gsettings reset io.github.alt-gnome-team.nautilus-backspace back