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

# Check if yay is installed and install it if not
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
i_nodeJS() { # NodeJS
	# installs nvm (Node Version Manager)
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
	# download and install Node.js (you may need to restart the terminal)
	nvm install 22
	# verifies the right Node.js version is in the environment
	node -v # should print `v22.7.0`
	# verifies the right npm version is in the environment
	npm -v # should print `10.8.2`
}
i_npms() { # Install Node Package Managers
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
	sudo pacman -S --noconfirm jdk-openjdk yt-dlp
	yay -S --noconfirm youtube-dl xdman --noconfirm
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

update_packages
