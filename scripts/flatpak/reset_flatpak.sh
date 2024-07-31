#!/bin/bash
# This script will:
# Stop and disable the Flatpak service if running.
# Uninstall all Flatpak applications.
# Remove Flatpak from the system.
# Clean up any remaining Flatpak directories.
# Optionally, reinstall Flatpak and set it up again.

# Function to confirm action
confirm() {
	read -p "$1 (y/n): " response
	if [[ "$response" != "y" && "$response" != "Y" ]]; then
		echo "Action cancelled."
		exit 1
	fi
}

echo "This script will reset Flatpak on your Arch Linux system."

# Confirm the action
confirm "Do you really want to reset Flatpak? This will remove all Flatpak applications and configurations"

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

# Optionally reinstall Flatpak
confirm "Do you want to reinstall Flatpak"
if [[ "$response" == "y" || "$response" == "Y" ]]; then
	echo "Reinstalling Flatpak..."
	sudo pacman -S flatpak --noconfirm

	echo "Setting up Flatpak..."

	# Add the Flathub repository
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	echo "Flatpak has been reinstalled and set up with Flathub repository."
else
	echo "Flatpak reset is complete. Flatpak is not reinstalled."
fi

echo "Flatpak reset process completed."
