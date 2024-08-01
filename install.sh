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

# ----------------------------------------------------
# Include Files:
# ----------------------------------------------------
source ./include/Global_functions
source ./include/welcome

# -------------------------------
# Check if pacman is available
# -------------------------------
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
prevent_sudo_or_root
# clear

# ---------------------------------------------------
# Show Welcome Message
# ---------------------------------------------------
_welcome

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
	"Lunacy - UI/UX and Web Designer Tool"
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
