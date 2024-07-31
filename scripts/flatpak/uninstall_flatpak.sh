#!/bin/bash
# a script to uninstall Flatpak on an Arch Linux system.
# This script will:
# Stop and disable any Flatpak-related services.
# Uninstall all Flatpak applications.
# Uninstall the Flatpak package.
# Remove any remaining Flatpak directories.

# Function to confirm action
confirm() {
	read -p "$1 (y/n): " response
	if [[ "$response" != "y" && "$response" != "Y" ]]; then
		echo "Action cancelled."
		exit 1
	fi
}

echo "This script will uninstall Flatpak from your Arch Linux system."

# Confirm the action
confirm "Do you really want to uninstall Flatpak? This will remove all Flatpak applications and configurations"

# Stop and disable any Flatpak-related services
echo "Stopping Flatpak services..."
sudo systemctl stop flatpak
sudo systemctl disable flatpak

# Uninstall all Flatpak applications
echo "Uninstalling all Flatpak applications..."
flatpak list --app --columns=application | xargs -r sudo flatpak uninstall -y

# Uninstall Flatpak
echo "Uninstalling Flatpak..."
sudo pacman -R flatpak --noconfirm

# Remove remaining Flatpak directories
echo "Removing remaining Flatpak directories..."
sudo rm -rf /var/lib/flatpak
rm -rf ~/.local/share/flatpak

echo "Flatpak has been uninstalled and all related directories have been removed."
