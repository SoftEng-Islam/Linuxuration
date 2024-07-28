#!/bin/bash

# Function to confirm action
confirm() {
	read -p "$1 (y/n): " response
	if [[ "$response" != "y" && "$response" != "Y" ]]; then
		echo "Action cancelled."
		exit 1
	fi
}

# Function to check the exit status of the last command and exit if it failed
check_exit_status() {
	if [[ $? -ne 0 ]]; then
		echo "Error: $1"
		exit 1
	fi
}

# Confirm the action
confirm "This script will set up Nautilus to support 'back' to previous path by clicking on backspace. Do you want to proceed?"

# Install the dependencies
echo "Installing dependencies..."
sudo pacman -Sy python-nautilus --noconfirm
check_exit_status "Failed to install python-nautilus."

# Clone the repository
cd ~/Downloads/
echo "Cloning the nautilus-backspace repository..."
git clone https://github.com/alt-gnome-team/nautilus-backspace.git
check_exit_status "Failed to clone the repository."

# Change to the repository directory
cd nautilus-backspace

# Build and install
echo "Building and installing nautilus-backspace..."
sudo make
check_exit_status "Make command failed."
sudo make schemas
check_exit_status "Make schemas command failed."

# Optionally change the key combination
# echo "Changing key combination to <Alt>Down..."
# gsettings set io.github.alt-gnome-team.nautilus-backspace back '<Alt>Down'
# check_exit_status "Failed to change key combination."

# Reset to the default value
# echo "Resetting key combination to default..."
# gsettings reset io.github.alt-gnome-team.nautilus-backspace back
# check_exit_status "Failed to reset key combination."

echo "Setup complete. Nautilus now supports 'back' to previous path by clicking on backspace."
