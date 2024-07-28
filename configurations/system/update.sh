#!/bin/bash
# ------------------------------------
# update script for Arch Linux
# ------------------------------------
# an update script for Arch Linux can help automate the process of keeping your system up to date.
# Below is an example of a simple bash script that performs system updates,
# including updating the package database, upgrading installed packages,
# and optionally removing unused packages and cleaning the package cache.
# ------------------------------------

# Function to print messages with a timestamp
log() {
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Update package database and upgrade all packages
log "Updating package database and upgrading all packages..."
sudo pacman -Syu --noconfirm

# Optionally remove orphaned packages
log "Removing orphaned packages..."
orphaned_packages=$(pacman -Qdtq)
if [[ ! -z "$orphaned_packages" ]]; then
	sudo pacman -Rns $orphaned_packages --noconfirm
else
	log "No orphaned packages to remove."
fi

# Optionally clean package cache
log "Cleaning package cache..."
sudo paccache -r

log "System update complete."
