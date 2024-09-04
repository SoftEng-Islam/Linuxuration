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

# ------------------------------------- #
# Check if pacman is available #
# ------------------------------------- #
# check if the pacman package manager is available on the system.
# If pacman is not found, it prints an error message indicating that
# the system is not Arch Linux or an Arch-based distribution,
# and then it exits the script with a status code of 1.
if ! command -v pacman >/dev/null 2>&1; then
	printf "\e[31m[$0]: pacman not found, it seems that the system is not ArchLinux or Arch-based distros. Aborting...\e[0m\n"
	exit 1
else
	echo "pacman is found. Continuing with the script..."
fi

# ------------------- #
# Update the Packages #
# ------------------- #
update_packages

# -------------------------------------------- #
# Microsoft Partition FileSystem Format 'NTFS' #
# -------------------------------------------- #
echo 'Install ntfs and fuse to Support MS Partition File System'
sudo pacman -S --noconfirm fuse3 ntfs-3g
sudo modprobe fuse
echo 'ntfs and fuse has been installed'
# use lsblk to get information about your disk
# change [partition] to your partition name like: /mnt/Data
# add this line to /etc/fstab
# /dev/disk/by-partlabel/[partition] /mnt/[partition] auto auto,nofail,nodev,uid=1000,gid=1000,utf8,umask=022,exec,x-gvfs-show 0 0


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

# set XDG variables
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
# print XDG variables
echo $XDG_CACHE_HOME
echo $XDG_CONFIG_HOME

# set WLR_VSYNC
export WLR_VSYNC=1

echo 'Disable Gnome Check-alive'
gsettings set org.gnome.mutter check-alive-timeout 0

# ------------------ #
# set plymouth theme #
# ------------------ #
sudo pacman -S plymouth
sudo plymouth-set-default-theme -R arch-logo
sudo mkinitcpio -p linux
sudo systemctl daemon-reload
systemctl status plymouth.service
ls /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R details

# ----------------------------- #
# Install Arch Package Managers #
# ----------------------------- #
# Check if yay is installed and install it if not
i_yay() {
	if ! command -v yay &>/dev/null; then
		echo "yay is not installed. Installing yay..."
		# Install yay
		sudo pacman -S --needed base-devel git
		# Clone the yay repository from the AUR
		git clone https://aur.archlinux.org/yay.git && cd yay
		# Build and install yay & Change back to the previous directory
		makepkg -si && cd ..
		# Remove the yay directory
		rm -rf yay
		echo "yay has been successfully installed."
	else
		echo "yay is already installed. Continuing with the script..."
	fi
}

i_paru() { # paru
	git clone https://aur.archlinux.org/paru.git && cd paru
	makepkg -si
}

# -------------------- #
# Install Apps & Tools #
# -------------------- #

i_git() { # git
	sudo pacman -S --noconfirm git
	# Set git configurations
	git 'config' --global core.autocrlf false
	git 'config' --global core.compression 9
	git 'config' --global http.postBuffer 924288000
	git 'config' --global http.lowSpeedLimit 0
	git 'config' --global http.lowSpeedTime 999999
	git 'config' --global submodule.fetchJobs 4
	git 'config' --global core.packedGitWindowSize 128m
	git 'config' --global core.packedGitLimit 512m
	git 'config' --global advice.addIgnoredFile false
}

i_xdman() { # xdman(Download Manager)
	sudo pacman -S --noconfirm jdk-openjdk yt-dlp
	yay -S --noconfirm youtube-dl xdman --noconfirm
}
i_FDM() {
	yay -S freedownloadmanager
}
i_motrix() { # motrix(Download Manager)
	yay -S --noconfirm motrix
}
i_brower() { # browsers (Ms Edge, Chrome, Firefox)
	yay -S --noconfirm microsoft-edge-stable-bin google-chrome
}

i_zsh() {
	# Install ZSH & oh-my-zsh
	sudo pacman -S --noconfirm zsh fzf
	# Install Plugins
	cd ~/.oh-my-zsh/custom/plugins/
	# Install zsh-autocomplete
	git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
	# Install zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	# Install zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
	# Install zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	# Set ZSH as default
	chsh -s /bin/zsh
	# Update ZSH
	exec zsh
	# Reload the configuration file (optional)
	source ~/.zshrc
}
i_vsCode() { # Microsoft Visual Studio Code
	yay -S visual-studio-code-bin
}

# =============================================================
# Just Install Some Programming Languages & Famous Development Tools
# and Frameworks, Tools that related to Web Development Stack.
# =============================================================

# NodeJS
i_nodeJS() { # NodeJS
	# installs nvm (Node Version Manager)
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
	# download and install Node.js (you may need to restart the terminal)
	nvm install 22
	# verifies the right Node.js version is in the environment
	node -v # should print `v22.7.0`
	# verifies the right npm version is in the environment
	npm -v # should print `10.8.2`

	# Set NPM Configurations
	npm config set registry https://registry.npmjs.org/
	npm config set prefer-offline true
	npm config set maxsockets 50
	npm config set fetch-retries 100
	npm config set fetch-retry-mintimeout 999999
	npm config set fetch-retry-maxtimeout 999999

	# Install yarn
	sudo pacman -S --noconfirm yarn
	yarn config set registry https://registry.yarnpkg.com/

	# Install pnpm
	sudo pacman -S --noconfirm pnpm
}
# Rust
# Dart
# Ruby
# GO
# C++
# C#
# python


# ---------------------
# Overclocing
# ---------------------
yay -S corectrl


# ------------------------------------------- #
# Install Flatpak Applications and Extensions #
# ------------------------------------------- #
i_flatpak() {
	sudo pacman -S flatpak --noconfirm
	# Add the Flathub remote
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	# Reboot your system (optional) Rebooting ensures that everything is properly set up, but its not strictly necessary.
	# sudo reboot
	# Increase the timeout settings for Flatpak
	FLATPAK_CONF="/etc/flatpak/flatpak.conf"
	echo "[Network]" | sudo tee -a $FLATPAK_CONF > /dev/null
	echo "RequestTimeout=1000" | sudo tee -a $FLATPAK_CONF > /dev/null
	echo "Timeout settings updated in $FLATPAK_CONF"
	# List of Flatpak applications to install (replace with your desired apps)

Applications=(
    # ------------------------------------------- // Audio/Video
    "com.github.rafostar.Clapper"                # Clapper
    "com.github.unrud.VideoDownloader"           # Video Downloader
    "com.obsproject.Studio"                      # OBS Studio
    "net.base_art.Glide"                         # Glide
    "org.audacityteam.Audacity"                  # Audacity
    "org.kde.kdenlive"                           # Kdenlive
    "org.gnome.eog"                              # Image Viewer

    # ------------------------------------------- // System
    "com.github.tchx84.Flatseal"                 # Flatseal
    "com.mattjakeman.ExtensionManager"           # Extension Manager
    "io.github.flattool.Warehouse"               # Warehouse
    "io.gitlab.adhami3310.Impression"            # Impression
    "io.missioncenter.MissionCenter"             # Mission Center
    "net.nokyan.Resources"                       # Resources
    "org.filezillaproject.Filezilla"             # Filezilla
    "org.gnome.Boxes"                            # Boxes
    "org.gnome.Calculator"                       # Calculator
    "org.gnome.Connections"                      # Connections
    "org.gnome.Loupe"                            # Loupe
    "org.gnome.Photos"                           # Photos
    "fr.romainvigier.MetadataCleaner"            # Metadata Cleaner

    # ------------------------------------------- // Browser
    "com.google.Chrome"                          # Google Chrome
    "com.microsoft.Edge"                         # Microsoft Edge
    "org.mozilla.firefox"                        # Firefox

    # ------------------------------------------- // Social
    "com.discordapp.Discord"                     # Discord
    "org.telegram.desktop"                       # Telegram

    # ------------------------------------------- // Productivity
    "com.jgraph.drawio.desktop"                  # draw.io
    "md.obsidian.Obsidian"                       # Obsidian
    "org.libreoffice.LibreOffice"                # LibreOffice
    "org.mozilla.Thunderbird"                    # Thunderbird

    # ------------------------------------------- // Image/Graphics
    "com.icons8.Lunacy"                          # Lunacy
    "io.gitlab.theevilskeleton.Upscaler"         # Image Upscaler
    "org.blender.Blender"                        # Blender
    "org.gimp.GIMP"                              # GIMP
    "org.inkscape.Inkscape"                      # Inkscape
    "org.kde.krita"                              # Krita
    "org.freecadweb.FreeCAD"                     # FreeCAD

    # ------------------------------------------- // Photography
    # (You can add more photography-related apps here as needed)

    # ------------------------------------------- // Gaming
    "org.gnome.Chess"                            # Chess

    # ------------------------------------------- // Development
    "com.getpostman.Postman"                     # Postman
    "com.slack.Slack"                            # Slack
    "com.visualstudio.code"                      # Visual Studio Code
    "io.beekeeperstudio.Studio"                  # Beekeeper Studio
    "io.dbeaver.DBeaverCommunity"                # DBeaver Community
    "rest.insomnia.Insomnia"                     # Insomnia
    "com.github.zadam.trilium"                   # Trilium
    "org.qbittorrent.qBittorrent"                # qBittorrent
)
	# Function to install Flatpak applications
	installFlatpakApps() {
		for app in "${APPS[@]}";
			echo "Installing $app..."
			flatpak install flathub $app -y
			echo "---------------------------------------------"
		done
	}
	# Main execution
	installFlatpakApps
	echo "All Flatpak applications installed successfully."
}
# ---------------------------------------- #
# To set microsoft edge as default Browser #
# ---------------------------------------- #
# xdg-settings set default-web-browser microsoft-edge.desktop
xdg-settings set default-web-browser com.microsoft.Edge.desktop
# --------------------------------- #
# to get whats you default browser? #
# --------------------------------- #
xdg-settings get default-web-browser
# --------------------------- #
# List all installed browsers #
# --------------------------- #
ls /usr/share/applications | grep edge
ls /var/lib/flatpak/exports/share/applications | grep edge
ls /var/lib/snapd/desktop/applications | grep edge
# --------------------------------- #
# To open a link in default browser #
# --------------------------------- #
xdg-open https://www.google.com
# ---------------------------------- #
# To open a link in specific browser #
# ---------------------------------- #
google-chrome https://www.google.com
# Update MIME Types (Optional)
# * To ensure that all relevant MIME types are associated with Microsoft Edge, you can use the xdg-mime command:
xdg-mime default com.microsoft.Edge.desktop x-scheme-handler/http
xdg-mime default com.microsoft.Edge.desktop x-scheme-handler/https
xdg-mime default com.microsoft.Edge.desktop text/html
xdg-mime default com.microsoft.Edge.desktop application/xhtml+xml
xdg-mime default com.microsoft.Edge.desktop application/xml
xdg-mime default com.microsoft.Edge.desktop application/x-extension-htm
xdg-mime default com.microsoft.Edge.desktop application/x-extension-html
xdg-mime default com.microsoft.Edge.desktop application/x-extension-shtml
xdg-mime default com.microsoft.Edge.desktop application/x-extension-xht
xdg-mime default com.microsoft.Edge.desktop application/x-extension-xhtml


# ------------------------------- #
# Switch to a gdm Display Manager #
# ------------------------------- #
sudo pacman -S gdm
sudo systemctl disable sddm.service
sudo systemctl enable gdm.service
sudo systemctl start gdm.service




# -------------------------- #
# Increase the Size of tmpfs #
# -------------------------- #
#* This will allow you to have a larger temporary directory, which can be useful for tools that use temporary files.
#* This will fix ERROR: Failed to write file “/run/user/1000/.flatpak/....”: write() failed: No space left on device

mount | grep /run/user/1000 # Check if it's a tmpfs.
sudo chown 1000:1000 /run/user/1000
sudo chmod 700 /run/user/1000
echo 'tmpfs /run/user/1000 tmpfs size=4G,mode=700,uid=1000,gid=1000 0 0' | sudo tee -a /etc/fstab;
d /run/user/1000 0700 softeng softeng 4G
sudo systemd-tmpfiles --create
mkdir -p /run/user/$(id -u)
export XDG_RUNTIME_DIR=/run/user/$(id -u)

# check if it's a tmpfs
df -h /run/user/1000 /run/user/1000





# ------------------------- #
# update the packages again #
# ------------------------- #
update_packages

# --------------------- #
# Clear Temporary Files #
# --------------------- #
sudo rm -rf /tmp/*

echo 'Scrip	Completed!'
echo 'Done!'
