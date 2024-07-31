#!/bin/bash
# -----------------------------------------
# Script to Install Waybar
# -----------------------------------------
# bash script to install Waybar along with its dependencies and some
# common modules and packages that users frequently use with Waybar.
# This script will install Waybar, some necessary dependencies,
# and set up a basic configuration for you.
# -----------------------------------------

# Function to print messages with a timestamp
log() {
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Update package database
log "Updating package database..."
sudo pacman -Syu --noconfirm

# Install Waybar and dependencies
log "Installing Waybar and dependencies..."
sudo pacman -S --noconfirm waybar swaybg pacman-contrib jq

# Install other commonly used packages and modules
log "Installing commonly used packages and modules..."
sudo pacman -S --noconfirm \
	networkmanager \
	network-manager-applet \
	pulseaudio \
	pulseaudio-alsa \
	pulseaudio-bluetooth \
	alsa-utils \
	bluez \
	bluez-utils \
	brightnessctl \
	acpi \
	lm_sensors

# Enable necessary services
log "Enabling NetworkManager and Bluetooth services..."
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth

# Create Waybar configuration directory
log "Creating Waybar configuration directory..."
mkdir -p ~/.config/waybar

# Create a basic config.json
log "Creating Waybar config.json..."
cat <<'EOF' >~/.config/waybar/config.json
{
    "layer": "top",
    "position": "top",
    "modules-left": ["sway/workspaces", "sway/mode"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "battery", "cpu", "memory"],
    "clock": {
        "format": "{:%Y-%m-%d %H:%M:%S}"
    },
    "battery": {
        "format": "{capacity}%"
    },
    "pulseaudio": {
        "format": "Vol: {volume}%"
    },
    "network": {
        "interface": "all",
        "format-wifi": "{essid} {signalStrength}%",
        "format-ethernet": "{ipaddr}/{cidr}"
    },
    "cpu": {
        "format": "CPU: {usage}%"
    },
    "memory": {
        "format": "RAM: {usedMem} MiB"
    }
}
EOF

# Create a basic style.css
log "Creating Waybar style.css..."
cat <<'EOF' >~/.config/waybar/style.css
* {
    font-family: "monospace";
    font-size: 12px;
}
#clock {
    background: #1E1E2E;
    color: #A6E3A1;
}
#pulseaudio {
    background: #2E2E3E;
    color: #F6A3A1;
}
#network {
    background: #3E3E4E;
    color: #A3E3F1;
}
#battery {
    background: #4E4E5E;
    color: #E3A1F1;
}
#cpu {
    background: #5E5E6E;
    color: #A3E3A1;
}
#memory {
    background: #6E6E7E;
    color: #E3A3A1;
}
EOF

# Add Waybar to Hyprland startup
log "Adding Waybar to Hyprland startup..."
if ! grep -q "exec-once = waybar" ~/.config/hypr/hyprland.conf; then
	echo "exec-once = waybar" >>~/.config/hypr/hyprland.conf
fi

log "Waybar installation and setup complete. Please restart your Hyprland session."
