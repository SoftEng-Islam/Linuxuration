#!/bin/bash
#script that installs MEGAsync (the MEGA cloud client) and its Nautilus extension on Arch Linux

wget https://mega.nz/linux/repo/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.zst && sudo pacman -U "$PWD/megasync-x86_64.pkg.tar.zst"
wget https://mega.nz/linux/repo/Arch_Extra/x86_64/nautilus-megasync-x86_64.pkg.tar.zst && sudo pacman -U "$PWD/nautilus-megasync-x86_64.pkg.tar.zst"


# Function to install yay if not already installed
# install_yay() {
#     if ! command -v yay &> /dev/null; then
#         echo "yay not found, installing yay..."
#         sudo pacman -S --needed --noconfirm git base-devel
#         git clone https://aur.archlinux.org/yay.git
#         cd yay
#         makepkg -si
#         cd ..
#         rm -rf yay
#     else
#         echo "yay is already installed."
#     fi
# }

# # Update system
# echo "Updating system..."
# sudo pacman -Syu

# # Install yay if necessary
# install_yay

# # Install MEGAsync and Nautilus extension
# echo "Installing MEGAsync and Nautilus extension..."
# yay -S --noconfirm megasync nautilus-megasync

# echo "Installation complete."