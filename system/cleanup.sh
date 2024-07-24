#!/bin/bash
# -------------------------------------
# Clean Up Script
# -------------------------------------

# Clean package cache
echo "Cleaning package cache..."
sudo pacman -Sc --noconfirm

# Remove all cached packages that are not currently installed
echo "Removing old cached packages..."
sudo paccache -r

# Remove orphaned packages
echo "Removing orphaned packages..."
sudo pacman -Rns $(pacman -Qtdq) --noconfirm

# Clean journal logs
echo "Cleaning journal logs..."
sudo journalctl --vacuum-time=2weeks

# Remove unused package files (optional)
echo "Removing unused package files..."
sudo pacman -Rns $(pacman -Qdtq) --noconfirm

echo "System cleanup complete."
