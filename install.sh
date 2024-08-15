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
_welcome

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
pacman -Sy --noconfirm ntfs-3g
modprobe fuse

# -------------------- #
# Install Flatpak Apps #
# -------------------- #
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
