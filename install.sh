#!/bin/bash
# -------------------------------------------------------
# The CONFARCH Project.
# Arch Linux enhancement configuration
# -------------------------------------------------------
# Warning
# Please don't use this script, still under development
# -------------------------------------------------------

# check if the pacman package manager is available on the system.
# If pacman is not found, it prints an error message indicating that
# the system is not Arch Linux or an Arch-based distribution,
# and then it exits the script with a status code of 1.
if ! command -v pacman >/dev/null 2>&1; then
	printf "\e[31m[$0]: pacman not found, it seems that the system is not ArchLinux or Arch-based distros. Aborting...\e[0m\n"
	exit 1
fi
echo "pacman is found. Continuing with the script..."

# ----------------------------------------------------
# Check if running as root. If root, script will exit
# ----------------------------------------------------
if [ $EUID -eq 0 ]; then
	echo "This script should not be executed as root! Exiting......."
	exit 1
fi
clear

# ------------------------------------
# set colors into vars
# ------------------------------------
# Regular Colors:
RBlack='\033[30m'
RRed='\033[31m'
RGreen='\033[32m'
RYellow='\033[33m'
RBlue='\033[34m'
RMagenta='\033[35m'
RCyan='\033[36m'
RWhite='\033[37m'

# Bright (Bold) Colors:
BrBlack='\033[90m'
BrRed='\033[91m'
BrGreen='\033[92m'
BrYellow='\033[93m'
BrBlue='\033[94m'
BrMagenta='\033[95m'
BrCyan='\033[96m'
BrWhite='\033[97m'

NC='\033[0m'
BOLD='\033[1m'
Italic='\033[3m'
Underline='\033[4m'
Strikethrough='\033[9m'

RESET="\033[0m" # Reset color

# Unicode Characters
# `echo -e "\u2764"   # Outputs a heart symbol (❤)`
heart='\u2764'

# ---------------------------------------------------------------
# Say Hello, and give the user some information about his device
# ---------------------------------------------------------------
echo -e "$(
	cat <<EOF

${RMagenta}===================================================================${RESET}
${RMagenta}= ${RESET} \e[31mWelcome\e[0m \e[1;32m$(whoami)\e[0m
${RMagenta}= ${RESET} Today's date is: \e[93m$(date)\e[0m
${RMagenta}= ${RESET} \e[3;90mfeel free to message me on\e[0m \e[1;34mTwitter\e[0m: \e[4;96mhttps://x.com/SoftEng_Islam\e[0m
${RMagenta}===================================================================${RESET} \n

EOF
)"

# ---------------------
# Update the Packages
# ---------------------
cd ~/Downloads/
echo 'Update the Packages'
# sudo -i
sudo rm /var/lib/pacman/db.lck
sudo pacman -Scc --noconfirm
sudo pacman -Syu --noconfirm && sudo pacman -Sc --noconfirm && yay -Syu --noconfirm --devel
sudo pacman -S --noconfirm linux-firmware
sudo mkinitcpio -P

# -----------------
# Install Packages
# -----------------
echo 'Install Needed Packages'
echo 'Install yay'
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# echo 'Install debtap by yay'
# yay -S debtap
# echo 'Initialize `debtap` (only needed the first time)'
# debtap -u

# Microsoft Partition FileSystem Format 'NTFS'
echo 'Install ntfs-3g to Support MS partition file system'
pacman -Sy --noconfirm ntfs-3g
modprobe fuse

# ----------------------------------------------------
# Install Flatpak Apps
# ----------------------------------------------------
echo 'Installing Resources App'
# List of Flatpak applications to install (replace with your desired apps)
APPS=(
	# "com.visualstudio.code"
	"org.mozilla.firefox"
	"com.microsoft.Edge"
	"com.google.Chrome"
	"net.nokyan.Resources"
	"com.mattjakeman.ExtensionManager"
	"org.qbittorrent.qBittorrent"
	"com.github.zadam.trilium"
	"org.gnome.Boxes"
	"com.getpostman.Postman"
	"io.dbeaver.DBeaverCommunity"
	"rest.insomnia.Insomnia"
	"com.discordapp.Discord"
	"org.telegram.desktop"
	"org.libreoffice.LibreOffice"
	"org.mozilla.Thunderbird"
	"md.obsidian.Obsidian"
	"org.gimp.GIMP"
	"org.kde.krita"
	"org.kde.kdenlive"
	"org.blender.Blender"
	"com.obsproject.Studio"
	"org.gnome.Chess"
	"Beekeeper Studio"
	"insomnia"
	"Lunacy - UI/UX and Web Designer Tool"
	"Krita"
	"blender"
	# Add more applications as needed
)
# Function to install Flatpak applications
install_flatpak_apps() {
	for app in "${APPS[@]}"; do
		echo "Installing $app..."
		flatpak install flathub $app -y
		echo "---------------------------------------------"
	done
}
# Main execution
install_flatpak_apps
echo "All Flatpak applications installed successfully."
