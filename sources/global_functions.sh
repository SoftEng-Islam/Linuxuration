#!/usr/bin/env bash

function prevent_sudo_or_root() {
	case $(whoami) in
	root)
		echo -e "\e[31m[$0]: This script is NOT to be executed with sudo or as root. Aborting...\e[0m"
		exit 1
		;;
	esac
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

# echo 'Install debtap by yay'
# yay -S debtap
# echo 'Initialize `debtap` (only needed the first time)'
# debtap -u
