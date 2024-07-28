#!/bin/bash

# -----------------------------------------
# Hyprland & Packages Installation Script
# https://wiki.hyprland.org/Getting-Started/Installation/
# -----------------------------------------

# ----------------------------------------------------------
# Step 1: Update System and Install Dependencies
# ----------------------------------------------------------

# Update the system and install essential build tools
sudo pacman -Syu --noconfirm base-devel cmake meson ninja bmake

# Install Wayland and related packages
sudo pacman -S --noconfirm wayland wayland-protocols libx11 libxkbcommon xcb-util-image xcb-util-wm xcb-util-xrm pixman pango cairo gdk-pixbuf2 gtk3 glibc

# Install additional dependencies required for Hyprland
yay -S --noconfirm gdb gcc libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libxcomposite xorg-xinput libxrender pixman cairo pango seatd libxkbcommon xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprland-git hyprcursor hyprwayland-scanner xcb-util-errors
yay -S hyprpicker-git

# ----------------------------------------------------------
# Step 2: Clone and Build Hyprland
# ----------------------------------------------------------

# Navigate to the Downloads directory
cd ~/Downloads

# Clone the Hyprland repository (uncomment the preferred method)
# Option 1: Clone directly from GitHub
# git clone --recursive https://github.com/hyprwm/Hyprland.git

# Option 2: Download a zip file from GitHub (alternative)
# wget -O Hyprland.zip https://github.com/hyprwm/Hyprland/archive/refs/heads/main.zip
# unzip Hyprland.zip

# Navigate to the Hyprland directory
cd Hyprland

# Clean any previous build files
rm -rf build

# Update the repository to ensure it's up to date
git pull
git submodule update --init --recursive

# Build and install Hyprland
meson setup build
ninja -C build
sudo ninja -C build install

# ----------------------------------------------------------
# Step 3: Install Additional Packages
# ----------------------------------------------------------

# List of additional packages for a complete Hyprland experience
hypr_packages=(
	curl
	gawk
	git
	grim
	gvfs
	gvfs-mtp
	ImageMagick
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
	SwayNotificationCenter
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
	sudo pacman -S --noconfirm $package
done

# ----------------------------------------------------------
# End of Script
# ----------------------------------------------------------

echo "Hyprland and all necessary packages have been installed successfully!"
