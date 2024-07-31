#!/bin/bash
# ---------------------------------
# Script to install Snap Store
# ---------------------------------
# Enable snaps on Arch Linux and install Snap Store
# Snaps are applications packaged with all their dependencies to run on all popular Linux distributions from a single build.
# They update automatically and roll back gracefully.

git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor.service
sudo ln -s /var/lib/snapd/snap /snap

# Either log out and back in again, or restart your system, to ensure snap’s paths are updated correctly.
sudo snap install snap-store
