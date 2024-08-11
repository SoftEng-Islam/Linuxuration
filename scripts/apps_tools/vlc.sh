#!/bin/bash

# Ensure the script runs with root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root."
	exit 1
fi

# Update the system
echo "Updating system..."
pacman -Syu --noconfirm

# Check for NVIDIA hardware
if lspci | grep -i 'nvidia' >/dev/null; then
	echo "NVIDIA hardware detected."
	echo "Installing NVIDIA drivers..."
	pacman -S --noconfirm nvidia nvidia-utils
else
	echo "NVIDIA hardware not detected."
fi

# Check for AMD hardware
if lspci | grep -i 'amd' >/dev/null; then
	echo "AMD hardware detected."
	echo "Installing AMD drivers..."
	pacman -S --noconfirm xf86-video-amdgpu
else
	echo "AMD hardware not detected."
fi

# Check for Intel hardware
if lspci | grep -i 'intel' | grep -i 'vga' >/dev/null; then
	echo "Intel hardware detected."
	echo "Installing Intel drivers..."
	pacman -S --noconfirm xf86-video-intel
else
	echo "Intel hardware not detected."
fi

# Install Wayland-related packages
echo "Installing Wayland-related packages..."
pacman -S --noconfirm wayland-protocols xdg-desktop-portal-wlr xdg-desktop-portal v4l-utils

# Set environment variables for Wayland
echo "Configuring environment variables..."
export QT_QPA_PLATFORM=xcb

# Reset VLC configuration
echo "Resetting VLC configuration..."
rm -rf ~/.config/vlc

# Install and use MPV as an alternative
echo "Installing MPV..."
pacman -S --noconfirm mpv

# Inform the user
echo "Setup completed. You can try running VLC with XWayland using: vlc --x11"
echo "Alternatively, you can use MPV with: mpv /path/to/media/file"

# Exit the script
exit 0
