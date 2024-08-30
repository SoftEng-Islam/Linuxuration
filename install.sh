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
# Function Check if pacman is available #
# ------------------------------------- #
# check if the pacman package manager is available on the system.
# If pacman is not found, it prints an error message indicating that
# the system is not Arch Linux or an Arch-based distribution,
# and then it exits the script with a status code of 1.
check_pacman() {
	if ! command -v pacman >/dev/null 2>&1; then
		printf "\e[31m[$0]: pacman not found, it seems that the system is not ArchLinux or Arch-based distros. Aborting...\e[0m\n"
		exit 1
	fi
	echo "pacman is found. Continuing with the script..."
}

# Function to check if yay is installed
check_yay() {
	if ! command -v yay &>/dev/null; then
		echo "yay is not installed. Please install yay and try again."
		exit 1
	fi
}
# Function to check if yay is installed and install it if not
check_yay() {
	if ! command -v yay &>/dev/null; then
		echo "yay is not installed. Installing yay..."
		# Install yay
		sudo pacman -S --needed base-devel git
		# Clone the yay repository from the AUR
		git clone https://aur.archlinux.org/yay.git
		# Change directory to yay
		cd yay
		# Build and install yay
		makepkg -si
		# Change back to the previous directory
		cd ..
		# Remove the yay directory
		rm -rf yay
		echo "yay has been successfully installed."
	else
		echo "yay is already installed."
	fi
}

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
# Install Apps & Tools #
# -------------------- #
i_paru() { # paru
	git clone https://aur.archlinux.org/paru.git && cd paru
	makepkg -si
}

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
i_nodeJS(){ # NodeJS
	# installs nvm (Node Version Manager)
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
	# download and install Node.js (you may need to restart the terminal)
	nvm install 22
	# verifies the right Node.js version is in the environment
	node -v # should print `v22.7.0`
	# verifies the right npm version is in the environment
	npm -v # should print `10.8.2`
}
i_npms(){ # Install Node Package Managers
	# Install NPM
	#sudo pacman -S --noconfirm npm

	# NPM configurations
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
i_xdman() { # xdman(Download Manager)
	sudo pacman -S --noconfirm  jdk-openjdk yt-dlp
	yay -S --noconfirm youtube-dl xdman --noconfirm
}
i_motrix() { # motrix(Download Manager)
	yay -S --noconfirm motrix
}
i_brower() { # browsers (Ms Edge, Chrome, Firefox)
yay -S --noconfirm microsoft-edge-stable-bin google-chrome
}

# =============================================================
# Just script to install some Programming Languages
# and Frameworks, Tools that related to Web Development Stack.
# =============================================================

# NodeJS

# PHP

# Rust

# Dart

# Ruby

# GO

# C++

# C#

# python
