#!/bin/bash
# xdm
# drow.io
# waydroid
# gparted

# ------------------------------------
# Add Microsoft repository for VS Code
# ------------------------------------
echo "Adding Microsoft repository for VS Code..."
echo "[code]" | sudo tee /etc/pacman.d/microsoft.repo echo "Server = https://packages.microsoft.com/yumrepos/vscode" >/dev/null | sudo tee -a /etc/pacman.d/microsoft.repo >/dev/null
sudo pacman -Sy --noconfirm
# Install VS Code echo "Installing Visual Studio Code..."
sudo pacman -S --noconfirm code
echo "Visual Studio Code installation completed."
