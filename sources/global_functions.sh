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
# -------------------------------------
# Clean Up Script
# -------------------------------------
# a cleanup script for Arch Linux can help maintain your system by removing unnecessary files, clearing caches, and managing orphaned packages. Below is an example of a simple bash script that performs common cleanup tasks:
# Clears the package cache
# Removes orphaned packages
# Cleans up unnecessary journal logs
# Removes unused package files
# -------------------------------------
# Run the script with root privileges
sudo -i

# Clean package cache
# This command clears the cache of uninstalled packages.
# The --noconfirm flag skips the confirmation prompt.
echo "Cleaning package cache..."
sudo pacman -Sc --noconfirm && sudo pacman -Scc --noconfirm

# Remove all cached packages that are not currently installed
# This command uses paccache (part of the pacman-contrib package) to remove old package files,
# keeping only the most recent three versions by default.
echo "Removing old cached packages..."
sudo paccache -r

# Remove orphaned packages
# This command removes orphaned packages (packages that were installed as dependencies but are no longer required).
echo "Removing orphaned packages..."
sudo pacman -Rns "$(pacman -Qtdq)" --noconfirm

# Clean journal logs
# This command cleans up system journal logs, keeping logs from the last two weeks.
echo "Cleaning journal logs..."
sudo journalctl --vacuum-time=1weeks

# Remove unused package files (optional)
echo "Removing unused package files..."
# This command is a repetition of the orphaned packages removal, ensuring any remaining orphaned packages are also removed.
sudo pacman -Rns "$(pacman -Qdtq)" --noconfirm
echo "System cleanup complete."
# exit
}
