#!/bin/bash
# =================================================
# Install OpenSnitch
# =================================================

# Install Dependencies
sudo pacman -S --noconfirm base-devel go python-protobuf python-qt-material qt5-wayland qt5-base python-virtualenv

# Install OpenSnitch from AUR
yay -S --noconfirm opensnitch

# Enable and Start OpenSnitch Service
sudo systemctl enable opensnitchd
sudo systemctl start opensnitchd

# Launch OpenSnitch GUI
# opensnitch-ui
