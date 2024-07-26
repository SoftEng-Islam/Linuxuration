#!/bin/bash

# -----------------------------------------
# Hyprland & Packages Installation Script
# https://wiki.hyprland.org/Getting-Started/Installation/
# -----------------------------------------

# Function to print the status
print_status() {
	echo "-----------------------------------------"
	echo "$1"
	echo "-----------------------------------------"
}

# Function to retry a command up to a specified number of times
retry() {
	local -r -i max_attempts="$1"
	shift
	local -i attempt_num=1
	until "$@"; do
		if ((attempt_num == max_attempts)); then
			echo "Attempt $attempt_num failed! No more attempts left."
			return 1
		else
			echo "Attempt $attempt_num failed! Retrying in $attempt_num seconds..."
			sleep $((attempt_num++))
		fi
	done
}

# Step 1: Update System and Install Dependencies
print_status "Updating system and installing dependencies..."
retry 3 sudo pacman -Syu --noconfirm gammastep base-devel cmake meson ninja bmake wayland wayland-protocols libx11 libxkbcommon xcb-util-image xcb-util-wm xcb-util-xrm pixman pango cairo gdk-pixbuf2 gtk3 glibc

# Install additional dependencies required for Hyprland
retry 3 yay -S --noconfirm gdb gcc libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libxcomposite xorg-xinput libxrender cairo pango seatd libxkbcommon xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprland-git hyprcursor hyprwayland-scanner xcb-util-errors

# Step 2: Clone and Build Hyprland
print_status "Cloning and building Hyprland..."
cd ~/Downloads || exit

# Clone the Hyprland repository
retry 3 git clone --recursive https://github.com/hyprwm/Hyprland.git

# Navigate to the Hyprland directory
cd Hyprland || exit

# Clean any previous build files
rm -rf build

# Update the repository to ensure it's up to date
retry 3 git pull
retry 3 git submodule update --init --recursive

# Build and install Hyprland
retry 3 meson setup build
retry 3 ninja -C build
retry 3 sudo ninja -C build install

# Step 3: Install Additional Packages
print_status "Installing additional packages..."
# List of additional packages for a complete Hyprland experience
hypr_packages=(
	curl
	gawk
	git
	grim
	gvfs
	gvfs-mtp
	imagemagick
	jq
	kitty
	kvantum
	nano
	network-manager-applet
	openssl
	pamixer
	pavucontrol
	pipewire-alsa
	pipewire-utils
	playerctl
	polkit-gnome
	python-requests
	python-pip
	python-pyquery
	qt5ct
	qt6ct
	qt6-qtsvg
	rofi-wayland
	slurp
	swappy
	swaynotificationcenter
	waybar
	wget2
	wl-clipboard
	wlogout
	xdg-user-dirs
	xdg-utils
	yad
	brightnessctl
	btop
	cava
	eog
	fastfetch
	gnome-system-monitor
	mousepad
	mpv
	mpv-mpris
	nvtop
	qalculate-gtk
	vim
)

# Install the additional packages
for package in "${hypr_packages[@]}"; do
	retry 3 sudo pacman -S --noconfirm "$package"
done

print_status "Hyprland and all necessary packages have been installed successfully!"
