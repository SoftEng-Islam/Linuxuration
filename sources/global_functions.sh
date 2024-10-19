#!/usr/bin/env bash

function prevent_sudo_or_root() {
  # Check if running as root. If root, script will exit
  if [[ $EUID -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting......."
    exit 1
  fi
}

# Function to confirm action
confirm() {
  read -p "$1 (y/n): " response
  if [[ "$response" != "y" && "$response" != "Y" ]]; then
    echo "Action cancelled."
    exit 1
  fi
}

# ------------------- #
# Update the Packages #
# ------------------- #
update_packages() {
  echo 'Update the Packages'
  sudo rm /var/lib/pacman/db.lck
  sudo pacman -Scc --noconfirm
  sudo pacman -Syu --noconfirm
  sudo pacman -Sc --noconfirm
  sudo pacman -Fy --noconfirm
  sudo pacman -S --noconfirm linux-firmware
  sudo mkinitcpio -P
}
clear_system() {
  sudo pacman -Scc
}
