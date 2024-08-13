#!/bin/bash
source ../../include/global_functions

# Check if yay is installed
check_yay

# Confirm the installation
confirm "Do you want to install Cloudflare WARP and enable its service?"

# Install Cloudflare WARP
echo "Installing Cloudflare WARP..."
yay -S --noconfirm cloudflare-warp-bin
if [[ $? -ne 0 ]]; then
	echo "Failed to install Cloudflare WARP. Exiting."
	exit 1
fi

# Enable and start the WARP service
echo "Enabling and starting the WARP service..."
sudo systemctl enable warp-svc --now
if [[ $? -ne 0 ]]; then
	echo "Failed to enable and start the WARP service. Exiting."
	exit 1
fi

echo "Cloudflare WARP has been installed and the service is running."
