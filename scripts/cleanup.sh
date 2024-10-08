#!/bin/bash
# -------------------------------------
# Clean Up Script
# -------------------------------------
# a cleanup script for Arch Linux can help maintain your system by removing unnecessary files, clearing caches, and managing orphaned packages. Below is an example of a simple bash script that performs common cleanup tasks:
# Clears the package cache
# Removes orphaned packages
# Cleans up unnecessary journal logs
# Removes unused package files
# -------------------------------------
# Run the script with root privileges
sudo -i

# Clean package cache
# This command clears the cache of uninstalled packages.
# The --noconfirm flag skips the confirmation prompt.
echo "Cleaning package cache..."
sudo pacman -Sc --noconfirm

# Remove all cached packages that are not currently installed
# This command uses paccache (part of the pacman-contrib package) to remove old package files,
# keeping only the most recent three versions by default.
echo "Removing old cached packages..."
sudo paccache -r

# Remove orphaned packages
# This command removes orphaned packages (packages that were installed as dependencies but are no longer required).
echo "Removing orphaned packages..."
sudo pacman -Rns $(pacman -Qtdq) --noconfirm

# Clean journal logs
# This command cleans up system journal logs, keeping logs from the last two weeks.
echo "Cleaning journal logs..."
sudo journalctl --vacuum-time=2weeks

# Remove unused package files (optional)
echo "Removing unused package files..."
# This command is a repetition of the orphaned packages removal, ensuring any remaining orphaned packages are also removed.
sudo pacman -Rns $(pacman -Qdtq) --noconfirm

echo "System cleanup complete."

exit
