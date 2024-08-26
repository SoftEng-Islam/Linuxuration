#!/usr/bin/env bash
cd "$(dirname "$0")"
export base="$(pwd)"
# -------------------------------------------------------
# The CONFARCH Project.
# Arch Linux enhancement configuration
# -------------------------------------------------------
# --------------------- Warning -------------------------
# Please don't use this script, still under development
# -------------------------------------------------------

#---------------------------------#
# Include variables and functions #
#---------------------------------#
source ./include/Global_functions
source ./include/welcome

# --------------------------------------------------- #
# Check if running as root. If root, script will exit #
# --------------------------------------------------- #
prevent_sudo_or_root
# clear

# ---------------------------------------------------
# Show Welcome Message
# ---------------------------------------------------
welcome

# ---------------------------- #
# Check if pacman is available #
# ---------------------------- #
check_pacman

# ------------------- #
# Update the Packages #
# ------------------- #
update_packages

# ----------------------------------------------------------- #
# Function to check if yay is installed and install it if not #
# ----------------------------------------------------------- #
check_yay

# -------------------------------------------- #
# Microsoft Partition FileSystem Format 'NTFS' #
# -------------------------------------------- #
echo 'Install ntfs-3g to Support MS partition file system'
pacman -S --noconfirm fuse3  ntfs-3g
modprobe fuse


# ----------------------------------------------
# Here will some Configuration
# ----------------------------------------------
# ----------------------------------------------------------
# This Command is used to add the current user to additional groups,
# specifically the video and input groups,
# on a Unix-like operating system
# ----------------------------------------------------------
# Explanation of Each Group:
## video: Access to video devices.
## input: Access to input devices like keyboards and mice.
## audio: Access to audio devices.
## network: Permissions to manage network connections.
## wheel: Ability to use sudo for administrative tasks.
## storage: Access to storage devices.
## lp: Manage printers.
## uucp: Access to serial ports and devices connected via serial ports.
sudo usermod -aG video,input,audio,network,wheel,storage,lp,uucp $(whoami)





# -------------------- #
# Install Flatpak Apps #
# -------------------- #