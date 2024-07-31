#!/bin/bash

# List installed snap packages
snap_list=$(snap list)

# Check if any snaps are installed
if [[ -n "$snap_list" ]]; then
	echo "The following snap packages are installed:"
	echo "$snap_list"
else
	echo "No snap packages are installed."
fi

# Ask the user for confirmation
read -p "Do you really want to uninstall Snap Store and all snap packages? (y/n): " confirmation

if [[ "$confirmation" == "y" || "$confirmation" == "Y" ]]; then
	echo "Uninstalling Snap Store and all snap packages..."

	# Stop and disable the snapd service
	sudo systemctl stop snapd
	sudo systemctl disable snapd

	# Remove all installed snap packages
	if [[ -n "$snap_list" ]]; then
		snap_packages=$(echo "$snap_list" | awk 'NR>1 {print $1}')
		for package in $snap_packages; do
			sudo snap remove "$package"
		done
	fi

	# Uninstall snapd
	sudo pacman -R snapd --noconfirm

	# Remove remaining snap directories
	sudo rm -rf /var/cache/snapd/
	sudo rm -rf /var/lib/snapd/

	echo "Snap Store and all snap packages have been uninstalled."
else
	echo "Uninstallation canceled."
fi
