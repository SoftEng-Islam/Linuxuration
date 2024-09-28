#!/usr/bin/env bash
# shellcheck disable=SC1090
# shellcheck disable=SC2034
# ------------------------------------------------------ #
#* The confArch Project.                                 #
#* Arch Linux enhancement configuration                  #
#! --------------------- Warning ----------------------- #
#? Please don't use this script, still under development #
# ------------------------------------------------------ #
# Table of Content #
# ---------------- #
# 1. Declare Variables.
#		relative Path
#		Colors
#		text format
#		Define the XDG
# 2. Import Global Scripts.
#		prevent_sudo_or_root
#		update_packages
# 3. Show Welcome Message.
# 4. Configurations.
# 5. Functions.
# 6. Install Applications & Tools.
# ------------------------------------------------------ #

if ! grep -q "arch" /etc/os-release; then
	echo ":: This script is designed to run on Arch Linux."
	exit 1
fi

if [ ! -d "$HOME/dotfiles" ]; then
	echo ":: The directory $HOME/dotfiles does not exist."
	exit 1
fi

execute_command() {
	while true; do
		"$@"
		exit_code=$?
		if [ $exit_code -eq 0 ]; then
			break
		else
			echo "Command failed with exit code $exit_code."
			choice=$(gum choose "Continue the script" "Retry the command" "Exit the script")
			case $choice in
			"Continue the script") break ;;
			"Retry the command") continue ;;
			"Exit the script") exit 1 ;;
			esac
		fi
	done
}

ask_continue() {
	local message=$1
	local exit_on_no=${2:-true}
	if gum confirm "$message"; then
		return 0
	else
		echo ":: Skipping $message."
		if $exit_on_no; then
			echo ":: Exiting script."
			exit 0
		else
			return 1
		fi
	fi
}
preference_select() {
	local type=$1
	shift
	local app_type=$1
	shift
	local options=("$@")

	gum style \
		--foreground 212 --border-foreground 212 --border normal \
		--align center --width 50 --margin "0 2" --padding "1 2" \
		"Select a(n) $type to install"

	CHOICE=$(gum choose "${options[@]}" "NONE")

	if [[ $CHOICE != "NONE" ]]; then
		execute_command yay -Sy
		execute_command yay -S --needed $CHOICE
		python -O "$HOME"/dotfiles/ags/scripts/apps.py --"$app_type" $CHOICE
	else
		echo "Not installing a(n) $type..."
		sleep .4
	fi
}

# -------------------- #
# 1. Declare Variables #
# -------------------- #
# store the relative path into `base` variable
export base && base="$(pwd)"

# Colors #
Black='\033[30m'
Red='\033[31m'
Green='\033[32m'
Yellow='\033[33m'
Blue='\033[34m'
Magenta='\033[35m'
Cyan='\033[36m'
White='\033[37m'
# Bright (Bold) Colors:
B_Black='\033[90m'
B_Red='\033[91m'
B_Green='\033[92m'
B_Yellow='\033[93m'
B_Blue='\033[94m'
B_Magenta='\033[95m'
B_Cyan='\033[96m'
B_White='\033[97m'

# text format
nc='\033[0m'
bold='\033[1m'
italic='\033[3m'
underline='\033[4m'
strikeThrough='\033[9m'
RESET="\033[0m" # Reset color

# Unicode Characters
heart='\u2764' # `echo -e "\u2764" Outputs a heart symbol (❤)`

# Define the XDG base directories using environment variables.
XDG_BIN_HOME=${XDG_BIN_HOME:-$HOME/.local/bin}
XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# ------------------------ #
# 2. Import Global Scripts #
# ------------------------ #
source "$(pwd)"/config.conf # Here your configuration file (you can Edit it)
source "$(pwd)"/sources/global_functions.sh
source "$(pwd)"/sources/system_information.sh
# --------------------------------------------------- #
# Check if running as root. If root, script will exit #
# --------------------------------------------------- #
prevent_sudo_or_root # The whole function exist in global_functions.sh file

# -------------------- #
# Show Welcome Message #
# -------------------- #
function welcome() {
	echo -e "$(
		cat <<EOF
		${B_Magenta}===================================================================${RESET}
		${B_Magenta}1 ${RESET} ${Red}Welcome${RESET} \e[1;32m$(whoami)\e[0m ${heart}
		${B_Magenta}2 ${RESET} Today's date is: ${B_Yellow}$(date)${RESET}
		${B_Magenta}3 ${RESET} \e[3;90mfeel free to message me on\e[0m \e[1;34mTwitter\e[0m: \e[4;96mhttps://x.com/SoftEng_Islam\e[0m
		${B_Magenta}===================================================================${RESET} \n
EOF
	)"
}
# Run welcome() Function
welcome

# ------------------------------------------------------ #
# Get and Show some Information about the current device #
# ------------------------------------------------------ #

# ---------------------------- #
# Check if pacman is available #
# ---------------------------- #
# check if the pacman package manager is available on the system.
# If pacman is not found, it prints an error message indicating that
# the system is not Arch Linux or an Arch-based distribution,
# and then it exits the script with a status code of 1.
if ! command -v pacman >/dev/null 2>&1; then
	echo -e "\e[31m[$0]: pacman not found, it seems that the system is not ArchLinux or Arch-based distros. Aborting...\e[0m\n"
	exit 1
else
	echo "pacman is found. Continuing with the script..."
fi

# ------------------- #
# Update the Packages #
# ------------------- #
update_packages

# -------------------------------- #
# Check if base-devel is installed #
# -------------------------------- #
if pacman -Q base-devel &>/dev/null; then
	echo "base-devel is already installed."
else
	echo "Install base-devel.........."
	if sudo pacman -S --noconfirm --needed base-devel linux-firmware linux-headers; then
		echo "base-devel has been installed successfully."
	else
		echo "Error: base-devel not found nor cannot be installed."
		echo "Please install base-devel manually before running this script... Exiting"
		exit 1
	fi
fi

install_yay() {
	echo ":: Installing yay..."
	execute_command sudo pacman -Sy
	execute_command sudo pacman -S --needed --noconfirm base-devel git
	execute_command git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay
	execute_command makepkg -si --noconfirm --needed
}
install_microtex() {
	cd ~/dotfiles/setup/MicroTex/
	execute_command makepkg -si
}

install_packages() {
	echo ":: Installing packages"
	sleep 1
	yay -Sy
	execute_command yay -S --needed \
		hyprland hyprshot hyprcursor hypridle hyprlang hyprpaper hyprpicker hyprlock \
		hyprutils hyprwayland-scanner xdg-dbus-proxy xdg-desktop-portal \
		xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-user-dirs \
		xdg-utils libxdg-basedir python-pyxdg aylurs-gtk-shell swww gtk3 gtk4 \
		adw-gtk-theme libdbusmenu-gtk3 python-pip python-pillow sddm \
		sddm-theme-corners-git nm-connection-editor network-manager-applet \
		networkmanager gnome-bluetooth-3.0 wl-gammarelay-rs bluez bluez-libs bluez-utils \
		cliphist wl-clipboard libadwaita swappy nwg-look \
		pavucontrol polkit-gnome brightnessctl man-pages gvfs xarchiver zip imagemagick \
		blueman fastfetch bibata-cursor-theme gum python-pywayland dbus \
		libdrm mesa fwupd bun-bin pipewire wireplumber udiskie \
		lm_sensors gnome-system-monitor playerctl ttf-meslo-nerd ttf-google-sans \
		ttf-font-awesome ttf-opensans ttf-roboto lshw ttf-material-symbols-variable-git \
		fontconfig dart-sass ttf-meslo-nerd-font-powerlevel10k cpio meson cmake \
		python-materialyoucolor-git gtksourceview3 gtksourceviewmm cairomm \
		gtkmm3 tinyxml2 python-requests python-numpy
}
setup_yay() {
	if command -v yay &>/dev/null; then
		echo ":: Yay is installed"
		sleep 1
	else
		echo ":: Yay is not installed!"
		sleep 1
		install_yay
	fi
}
setup_sensors() {
	execute_command sudo sensors-detect --auto >/dev/null
}

check_config_folders() {
	local CHECK_CONFIG_FOLDERS="ags alacritty hypr swappy"
	local DATETIME=$(date '+%Y-%m-%d %H:%M:%S')
	local EXISTING="NO"

	mkdir -p "$HOME/.backup/$DATETIME/"

	for dir in $CHECK_CONFIG_FOLDERS; do
		if [ -d "$HOME/.config/$dir" ]; then
			echo ":: Attention: directory $dir already exists in .config"
			mv $HOME/.config/$dir "$HOME/.backup/$DATETIME/"
			EXISTING="YES"
		fi
	done

	if [[ $EXISTING == "YES" ]]; then
		echo ":: Old config folder(s) backed up at ~/.backup folder"
	fi
}

install_icon_theme() {
	gum style \
		--foreground 212 --border-foreground 212 --border normal \
		--align center --width 50 --margin "0 2" --padding "1 2" \
		"Select an icon theme to install"

	CHOICE=$(gum choose "Tela Icon Theme" "Papirus Icon Theme" "Adwaita Icon Theme")

	if [[ $CHOICE == "Tela Icon Theme" ]]; then
		echo ":: Installing Tela icons..."
		mkdir -p /tmp/install
		cd /tmp/install
		git clone https://github.com/vinceliuice/Tela-icon-theme
		cd Tela-icon-theme

		gum style \
			--foreground 212 --border-foreground 212 --border normal \
			--align center --width 50 --margin "0 2" --padding "1 2" \
			"Select a color theme"

		COLOR_CHOICE=$(gum choose --height=20 "nord" "black" "blue" "green" "grey" "orange" \
			"pink" "purple" "red" "yellow" "brown")

		./install.sh $COLOR_CHOICE
		echo -e "Tela-$COLOR_CHOICE-dark\nTela-$COLOR_CHOICE-light" >$HOME/dotfiles/.settings/icon-theme
		cd $HOME/dotfiles

	elif [[ $CHOICE == "Papirus Icon Theme" ]]; then
		yay -S --noconfirm --needed papirus-icon-theme papirus-folders

		echo -e "Papirus-Dark\nPapirus-Light" >$HOME/dotfiles/.settings/icon-theme

		gum style \
			--foreground 212 --border-foreground 212 --border normal \
			--align center --width 50 --margin "0 2" --padding "1 2" \
			"Select a color theme"

		COLOR_CHOICE=$(gum choose --height=20 "black" "blue" "cyan" "green" "grey" "indigo" \
			"brown" "purple" "nordic" "pink" "red" "deeporange" "white" "yellow")

		papirus-folders -C $COLOR_CHOICE

	else
		yay -S --noconfirm --needed adwaita-icon-theme
		echo -e "Adwaita\nAdwaita" >$HOME/dotfiles/.settings/icon-theme
	fi
}

setup_colors() {
	echo ":: Setting colors"
	execute_command python -O $HOME/dotfiles/material-colors/generate.py --color "#0000FF"
}
setup_sddm() {
	echo ":: Setting SDDM"
	sudo mkdir -p /etc/sddm.conf.d
	sudo cp $HOME/dotfiles/sddm/sddm.conf /etc/sddm.conf.d/
	sudo cp $HOME/dotfiles/sddm/sddm.conf /etc/
	sudo chmod 777 /etc/sddm.conf.d/sddm.conf
	sudo chmod 777 /etc/sddm.conf
	sudo chmod -R 777 /usr/share/sddm/themes/corners/
	"$HOME"/dotfiles/sddm/scripts/wallpaper.sh
}
copy_files() {
	echo ":: Copying files"
	mkdir -p $HOME/.config
	"$HOME"/dotfiles/setup/copy.sh
	if [ -d "$HOME/wallpaper" ]; then
		echo ":: Error: directory wallpaper already exists in home"
	else
		cp -r $HOME/dotfiles/wallpapers $HOME/wallpaper
	fi
}
create_links() {
	echo ":: Creating links"
	ln -f $HOME/dotfiles/electron-flags.conf $HOME/.config/electron-flags.conf
	ln -s $HOME/dotfiles/ags $HOME/.config/ags
	ln -s $HOME/dotfiles/alacritty $HOME/.config/alacritty
	ln -s $HOME/dotfiles/hypr $HOME/.config/hypr
	ln -s $HOME/dotfiles/swappy $HOME/.config/swappy
}
remove_gtk_buttons() {
	echo ":: Remove window close and minimize buttons in GTK"
	gsettings set org.gnome.desktop.wm.preferences button-layout ':'
}

setup_services() {
	echo ":: Services"

	if systemctl is-active --quiet bluetooth.service; then
		echo ":: bluetooth.service already running."
	else
		sudo systemctl enable bluetooth.service
		sudo systemctl start bluetooth.service
		echo ":: bluetooth.service activated successfully."
	fi

	if systemctl is-active --quiet NetworkManager.service; then
		echo ":: NetworkManager.service already running."
	else
		sudo systemctl enable NetworkManager.service
		sudo systemctl start NetworkManager.service
		echo ":: NetworkManager.service activated successfully."
	fi
}

update_user_dirs() {
	echo ":: User dirs"
	xdg-user-dirs-update
}

misc_tasks() {
	echo ":: Misc"
	hyprctl reload
	ags --init
	execute_command python $HOME/dotfiles/hypr/scripts/wallpaper.py -R
}

main() {
	if [[ $1 == "packages" ]]; then
		setup_yay
		install_packages
		exit 0
	fi

	setup_yay
	if ! command -v gum &>/dev/null; then
		echo ":: gum not installed"
		execute_command sudo pacman -S gum
	fi

	ask_continue "Proceed with installing packages?" false && install_packages
	preference_select "file manager" "filemanager" "nautilus" "dolphin" "thunar"
	preference_select "internet browser" "browser" "brave" "firefox" "google-chrome" "chromium"
	preference_select "terminal emulator" "terminal" "alacritty" "kitty" "konsole"
	ask_continue "Proceed with installing MicroTex?" false && install_microtex
	ask_continue "Proceed with setting up sensors?" false && setup_sensors
	ask_continue "Proceed with checking config folders?*" && check_config_folders
	ask_continue "Proceed with installing icon themes?" false && install_icon_theme
	ask_continue "Proceed with setting up SDDM?" false && setup_sddm
	ask_continue "Proceed with copying files?*" && copy_files
	ask_continue "Proceed with creating links?*" && create_links
	ask_continue "Proceed with setting up colors?*" && setup_colors
	ask_continue "Proceed with installing Vencord?" false && install_vencord
	ask_continue "Proceed with removing GTK buttons?" false && remove_gtk_buttons
	ask_continue "Proceed with setting up services?*" && setup_services
	ask_continue "Proceed with updating user directories?*" && update_user_dirs
	ask_continue "Proceed with miscellaneous tasks?*" && misc_tasks

	echo "Please restart your PC"
}

main "$@"

# ----------------------------------------------------------
# Modify System Configurations
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
sudo usermod -aG video,input,audio,network,wheel,storage,lp,uucp "$(whoami)"

# ----------------------------- #
# Disabling Split Lock Mitigate #
# ----------------------------- #
# In some cases, split lock mitigate can slow down performance in some applications and games.
# You can disable it via sysctl.
sudo sysctl kernel.split_lock_mitigate=0

# ------------------------ #
# Set Performance Governor #
# ------------------------ #
sudo cpupower frequency-set -g performance

# ---------------------------------- #
# AMD P-State Core Performance Boost #
# Enable boost for all cores         #
# ---------------------------------- #
echo 1 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/boost
# Disable boost for all cores
# echo 0 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/boost

# ------------------------------------- #
# Declare and set environment variables #
# ------------------------------------- #
export XDG_RUNTIME_DIR
export XDG_CACHE_HOME
export XDG_CONFIG_HOME
export XDG_DATA_HOME
export WLR_VSYNC

XDG_CACHE_HOME="$HOME/.cache"
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
XDG_RUNTIME_DIR="/run/user/$(id -u)"
WLR_VSYNC=1

# ------------------------------------------------- #
# Enable Wayland support for different applications #
# ------------------------------------------------- #
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	export WAYLAND=1
	export QT_QPA_PLATFORM='wayland;xcb'
	export GDK_BACKEND='wayland,x11'
	export MOZ_DBUS_REMOTE=1
	export MOZ_ENABLE_WAYLAND=1
	export _JAVA_AWT_WM_NONREPARENTING=1
	export BEMENU_BACKEND=wayland
	export CLUTTER_BACKEND=wayland
	export ECORE_EVAS_ENGINE=wayland_egl
	export ELM_ENGINE=wayland_egl
fi
# ----------------------------------- #
# Disable & Enable Mouse Acceleration #
# ----------------------------------- #
disable_mouse-acceleration() {
	sudo tee /etc/udev/rules.d/90-mouse-acceleration.rules <<EOF >/dev/null
ACTION=="add", SUBSYSTEM=="input", ENV{ID_INPUT_MOUSE}=="1", ENV{LIBINPUT_ACCEL_PROFILE}="flat"
EOF
	sudo udevadm control --reload-rules
	sudo udevadm trigger
	# libinput list-devices | grep Accel
}
enable_mouse-acceleration() {
	sudo rm -rf /etc/udev/rules.d/90-mouse-acceleration.rules
	sudo udevadm control --reload-rules
	sudo udevadm trigger
	# libinput list-devices | grep Accel
}

# mouse speed
libinput list-devices # Get Devices
# Set mouse speed (sensitivity): If you're aiming to change the sensitivity dynamically, you can use a tool like xinput:
xinput --set-prop "YSPRINGTECH USB OPTICAL MOUSE" "libinput Accel Speed" 0
# Replace 0.5 with a value between -1 (slowest) and 1 (fastest) based on your preference.

xinput --set-prop "YSPRINGTECH USB OPTICAL MOUSE" "libinput Accel Profile Enabled" 1, 0
xinput --set-prop "YSPRINGTECH USB OPTICAL MOUSE" "libinput Accel Speed" -1
xinput --set-prop "YSPRINGTECH USB OPTICAL MOUSE" "libinput Middle Emulation Enabled" 1
xinput --set-prop "YSPRINGTECH USB OPTICAL MOUSE" "libinput Scroll Method Enabled" 0, 1, 0
xinput --set-prop "YSPRINGTECH USB OPTICAL MOUSE" "libinput Natural Scrolling Enabled" 1

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

# ------------------------------
# Disable Gnome Check-alive
# ------------------------------
echo 'Disable Gnome Check-alive'
gsettings set org.gnome.mutter check-alive-timeout 0

# --------------------------------- #
# Install Git and set Configuration #
# --------------------------------- #
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
	git 'config' --global http.version HTTP/1.1

}

# -------------------------- #
# Install GTK themes & icons #
# -------------------------- #
# Cursor Icons
# System & apps Icons
# GTK Themes
git clone https://github.com/JaKooLit/GTK-themes-icons.git --depth 1
cd GTK-themes-icons || exit
chmod +x auto-extract.sh
./auto-extract.sh

# ------------------ #
# Set Plymouth Theme #
# ------------------ #
set_plymouth_theme() {
	sudo pacman -S plymouth
	sudo plymouth-set-default-theme -R arch-logo
	sudo mkinitcpio -p linux
	sudo systemctl daemon-reload
	systemctl status plymouth.service
	ls /usr/share/plymouth/themes/
	sudo plymouth-set-default-theme -R details
}

# -------------------------------------------------------
# Nautilus backspace
# Extensions for returning back to Nautilus by pressing the combination of keys assigned via Gsettings
# -------------------------------------------------------
i_nautilus_backspace() {
	sudo pacman -Sy python-nautilus
	git clone https://github.com/SoftEng-Islam/nautilus-backspace.git
	cd nautilus-backspace || exit
	sudo make
	sudo make schemas
}

# ----------------------------- #
# Install Arch Package Managers #
# ----------------------------- #
# Check if yay is installed and install it if not
# Yay (Yet Another Yaourt)
# Yay is an AUR helper written in Go, designed to interact with both the official Arch repositories and the AUR (Arch User Repository).
pacman_helpers() {
	i_yay() {
		if ! command -v yay &>/dev/null; then
			echo "yay is not installed. Installing yay..."
			# Install yay
			sudo pacman -S --needed base-devel git
			# Clone the yay repository from the AUR
			git clone https://aur.archlinux.org/yay.git && cd yay || exit
			# Build and install yay & Change back to the previous directory
			makepkg -si && cd ..
			# Remove the yay directory
			rm -rf yay
			echo "yay has been successfully installed."
		else
			echo "yay is already installed. Continuing with the script..."
		fi
	}
	# --------------------------------------------------------------------------
	# Pikaur
	# Pikaur is another AUR helper that’s known for its simplicity and speed.
	# --------------------------------------------------------------------------
	i_pikaur() {
		# Clone the pikaur repository from the AUR
		git clone https://aur.archlinux.org/pikaur.git
		# Navigate into the pikaur directory
		cd pikaur || exit
		# Build and install pikaur
		makepkg -si
	}
	# --------------------------------------------------------------------------
	# Paru
	# Paru is another popular AUR helper that’s similar to Yay but written in Rust.
	# --------------------------------------------------------------------------
	i_paru() { # paru
		git clone https://aur.archlinux.org/paru.git
		cd paru || exit
		makepkg -si
	}
	# --------------------------------------------------------------------------
	# Trizen
	# Trizen is an AUR helper written in Perl and has a similar syntax to Pacman.
	# --------------------------------------------------------------------------
	i_trizen() {
		# Clone the trizen repository from the AUR
		git clone https://aur.archlinux.org/trizen.git
		# Navigate into the trizen directory
		cd trizen || exit
		# Build and install trizen
		makepkg -si
	}
}

# configure fonts
i_fonts() {
	sudo mkdir -p /home/softeng/.local/share/flatpak/exports/share/fonts
	sudo mkdir -p /var/lib/flatpak/exports/share/fonts
	# sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono ttf-jetbrains-mono-nerd
	# Set variables
	FONT_URL="https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip"
	FONT_DIR="/usr/share/fonts/JetBrainsMono"
	# Create font directory
	echo "Creating font directory: $FONT_DIR"
	sudo mkdir -p "$FONT_DIR"
	# Download JetBrains Mono
	echo "Downloading JetBrains Mono from $FONT_URL..."
	wget "$FONT_URL" -O /tmp/JetBrainsMono.zip
	# Extract the font
	echo "Extracting the font to /tmp..."
	unzip /tmp/JetBrainsMono.zip -d /tmp/JetBrainsMono
	# Install the font
	echo "Installing JetBrains Mono to $FONT_DIR..."
	sudo cp /tmp/JetBrainsMono/fonts/ttf/*.ttf "$FONT_DIR"
	# Set proper permissions
	echo "Setting correct permissions for $FONT_DIR..."
	sudo chmod 644 "$FONT_DIR"/*.ttf
	sudo fc-cache -fv
	# Clean up
	echo "Cleaning up temporary files..."
	rm -rf /tmp/JetBrainsMono /tmp/JetBrainsMono.zip
	# Done
	echo "JetBrains Mono installed successfully!"
}

# ---------------------- #
# Task & To-Do List Apps #
# ---------------------- #
# i_tasks_apps() {

# }

# -------------------- #
# Time Management Apps #
# -------------------- #
i_time_apps() { # Install Pomodoro Apps
	sudo pacman -S --noconfirm psutils \
		perl-tk biber mupdf-tools \
		dblatex gperftools groff mono r \
		xterm blas-openblas gcc-fortran xorg-mkfontscale

	yay -S --noconfirm sct pigz criu gnome-pomodoro pomodorolm-bin
}

# -----------------
# Install Steam
# -----------------
i_steam() {
	sudo pacman -S lib32-librsvg gnome-themes-standard gtk-engines lib32-libid3tag lib32-libva-mesa-driver lib32-mesa-vdpau lib32-fluidsynth --noconfirm
	sudo pacman -S steam-native-runtime steam
	# Enable 32-bit Libraries (if needed):
	# Some games require 32-bit libraries. If you face issues with games, you may need to install additional libraries:
	sudo pacman -S lib32-alsa-plugins lib32-alsa-lib lib32-libpulse lib32-openal lib32-libxcomposite
	# Install Graphics Drivers (Optional):
	# Make sure you have the appropriate drivers installed for your GPU. For example, for NVIDIA:
	sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils
	# For AMD:
	sudo pacman -S mesa lib32-mesa
	# -----------------------------------
	# Install Necessary Dependencies
	# Install Vulkan libraries:
	sudo pacman -S vulkan-icd-loader lib32-vulkan-icd-loader
	# For AMD GPUs:
	sudo pacman -S mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon
	# For NVIDIA GPUs:
	sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils
	# For Intel GPUs:
	sudo pacman -S vulkan-intel lib32-vulkan-intel
	# Install DXVK and VKD3D (if required):
	sudo pacman -S dxvk vkd3d
}

# ----------------- #
# Install Ulauncher #
# ----------------- #
# git clone https://aur.archlinux.org/ulauncher.git
# cd ulauncher && makepkg -is

# -------------------- #
# Install Apps & Tools #
# -------------------- #
downloaders() {
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
}

# Install Browsers
i_chrome() { # Install Google Chrome
	yay -S --noconfirm google-chrome
}
i_msedge() { # Install Microsoft Edge
	yay -S --noconfirm microsoft-edge-stable-bin
}

# Install and Configure Terminals
i_zsh() { # Install ZSH & oh-my-zsh
	sudo pacman -S --noconfirm zsh fzf
	# Install Plugins
	cd ~/.oh-my-zsh/custom/plugins/ || exit
	# Install zsh-autocomplete
	git clone https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autocomplete
	# Install zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	# Install zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-history-substring-search
	# Install zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
	# Set ZSH as default
	chsh -s /bin/zsh
	# Update ZSH
	exec zsh || exec bash
	# Reload the configuration file (optional)
	source ~/.zshrc
}

# -----------------------------------------------------
# Install GStreamer Plugins
# This should provide support for most media formats
# -----------------------------------------------------
i_GStreamer() {
	sudo pacman -S gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gstreamer gst-libav
}

# Install Editors
i_vsCode() { # Install Microsoft Visual Studio Code
	yay -S visual-studio-code-bin
}
i_zed() { # Install Zed
	# To install Zed on most Linux distributions, run this shell script:
	# https://zed.dev/blog/zed-on-linux
	curl -f https://zed.dev/install.sh | sh
	echo "export PATH=$HOME/.local/bin:$PATH" >>~/.zshrc
	source ~/.zshrc
}

# =============================================================
# Install Programming Languages & Famous Development Tools
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

# Install rust Programming Language
i_rust() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

	sudo pacman -S rust-src

	# Install rust-analyzer
	sudo pacman -S rust-analyzer
}

# ---------------------------- #
# Install Wine & windows Tools #
# ---------------------------- #
i_wine() {
	sudo pacman -S wine wine-mono wine-gecko winetricks
	# AMD Drivers Install vulkan for better performance in games:
	sudo pacman -S vulkan-radeon lib32-vulkan-radeon
	# Install mesa for OpenGL support (already installed in most cases):
	sudo pacman -S mesa lib32-mesa
	# For DirectX 12 and Vulkan translation, consider installing DXVK:
	sudo pacman -S dxvk

	# Enable DXVK in Wine:
	# WINEPREFIX=~/.wine winecfg
	# Go to the Libraries tab, add d3d11 and dxgi, and set them to "native."

	# For better FPS, enable esync or fsync if supported:
	export WINEESYNC=1
	export WINEFSYNC=1
	# export DXVK_HUD=1  # Shows FPS and other useful info during the game
}

# ----------------------------- #
# Install Audio Driver and Libs #
# ----------------------------- #
i_audio() {
	# For PulseAudio:
	sudo pacman -S lib32-pulseaudio lib32-alsa-plugins
	# For PipeWire (if you're using PipeWire instead of PulseAudio):
	sudo pacman -S lib32-pipewire lib32-alsa-plugins lib32-dbus lib32-jack lib32-libavtp lib32-libsamplerate lib32-libpulse lib32-speexdsp
	# Check Audio Configuration in PipeWire/PulseAudio
	systemctl --user status pulseaudio
	systemctl --user status pipewire
	systemctl --user start pulseaudio
	systemctl --user start pipewire
	sudo pacman -S pavucontrol
	# pavucontrol
}

# ---------------------- #
# Overclocking & drivers #
# ---------------------- #
i_oc() {
	sudo pacman -S vulkan-tools qt5-wayland xf86-video-amdgpu
	yay -S corectrl
}

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
	echo "[Network]" | sudo tee -a $FLATPAK_CONF >/dev/null
	echo "RequestTimeout=1000" | sudo tee -a $FLATPAK_CONF >/dev/null
	echo "Timeout settings updated in $FLATPAK_CONF"
	# List of Flatpak applications to install
	Applications=(
		# ------------------------------------------- // Audio/Video
		"com.github.rafostar.Clapper"      # Clapper
		"com.github.unrud.VideoDownloader" # Video Downloader
		"com.obsproject.Studio"            # OBS Studio
		"net.base_art.Glide"               # Glide
		"org.audacityteam.Audacity"        # Audacity
		"org.kde.kdenlive"                 # Kdenlive
		"org.gnome.eog"                    # Image Viewer

		# ------------------------------------------- // System
		"com.github.tchx84.Flatseal"       # Flatseal
		"com.mattjakeman.ExtensionManager" # Extension Manager
		"io.github.flattool.Warehouse"     # Warehouse
		"io.gitlab.adhami3310.Impression"  # Impression
		"io.missioncenter.MissionCenter"   # Mission Center
		"net.nokyan.Resources"             # Resources
		"org.filezillaproject.Filezilla"   # Filezilla
		"org.gnome.Boxes"                  # Boxes
		"org.gnome.Calculator"             # Calculator
		"org.gnome.Connections"            # Connections
		"org.gnome.Loupe"                  # Loupe
		"org.gnome.Photos"                 # Photos
		"fr.romainvigier.MetadataCleaner"  # Metadata Cleaner

		# ------------------------------------------- // Browser
		"com.google.Chrome"   # Google Chrome
		"com.microsoft.Edge"  # Microsoft Edge
		"org.mozilla.firefox" # Firefox

		# ------------------------------------------- // Social
		"com.discordapp.Discord" # Discord
		"org.telegram.desktop"   # Telegram

		# ------------------------------------------- // Productivity
		"com.jgraph.drawio.desktop"   # draw.io
		"md.obsidian.Obsidian"        # Obsidian
		"org.libreoffice.LibreOffice" # LibreOffice
		"org.mozilla.Thunderbird"     # Thunderbird

		# ------------------------------------------- // Image/Graphics
		"com.icons8.Lunacy"                  # Lunacy
		"io.gitlab.theevilskeleton.Upscaler" # Image Upscaler
		"org.blender.Blender"                # Blender
		"org.gimp.GIMP"                      # GIMP
		"org.inkscape.Inkscape"              # Inkscape
		"org.kde.krita"                      # Krita
		"org.freecadweb.FreeCAD"             # FreeCAD

		# ------------------------------------------- // Photography
		# (You can add more photography-related apps here as needed)

		# ------------------------------------------- // Gaming
		"org.gnome.Chess" # Chess

		# ------------------------------------------- // Development
		"com.getpostman.Postman"      # Postman
		"com.slack.Slack"             # Slack
		"com.visualstudio.code"       # Visual Studio Code
		"io.beekeeperstudio.Studio"   # Beekeeper Studio
		"io.dbeaver.DBeaverCommunity" # DBeaver Community
		"rest.insomnia.Insomnia"      # Insomnia
		"com.github.zadam.trilium"    # Trilium
		"org.qbittorrent.qBittorrent" # qBittorrent
	)
	# Function to install Flatpak applications
	installFlatpakApps() {
		for app in "${Applications[@]}"; do
			echo "Installing $app..."
			flatpak install flathub "$app" -y
			echo "---------------------------------------------"
		done
	}
	# Main execution
	installFlatpakApps
	echo "All Flatpak applications installed successfully."
}
# ------------------------------- #
# Function to set default Browser #
# ------------------------------- #
set_default_browser() {
	# To set microsoft edge as default Browser
	xdg-settings set default-web-browser com.microsoft.Edge.desktop
	xdg-settings get default-web-browser # to get whats you default browser?
	# List all installed browsers #
	# ls /usr/share/applications | grep edge
	# ls /var/lib/flatpak/exports/share/applications | grep edge
	# ls /var/lib/snapd/desktop/applications | grep edge
	xdg-open https://www.google.com      # To open a link in default browser
	google-chrome https://www.google.com # To open a link in specific browser
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
}

# ----------------------- #
# Install Display Manager #
# ----------------------- #
display_managers=(
	"gdm"
	"sddm"
	"lightdm"
)
i_display_manager() {
	# Get current display manager and store it in variable:
	readdm_service=$(readlink /etc/systemd/system/display-manager.service)
	display_manager=$(basename "$readdm_service" .service)
	echo display_manager is: "$display_manager"

	# other way to get display manager:
	# systemd-analyze blame | grep -E 'gdm|sddm|lightdm|xdm|lxdm' | head -n1 | awk '{print $2}' | sed 's/\.service//'

	sudo pacman -S gdm
	sudo systemctl disable sddm.service
	sudo systemctl enable gdm.service
	sudo systemctl start gdm.service
}

# -------------------------- #
# Increase the Size of tmpfs #
# -------------------------- #
#* This will allow you to have a larger temporary directory, which can be useful for tools that use temporary files.
#* This will fix ERROR: Failed to write file “/run/user/1000/.flatpak/....”: write() failed: No space left on device
increase_tmpfs() {
	# You can't set any Number It deb in Your RAM
	mount | grep /run/user/1000         # Check if it's a tmpfs.
	sudo chown 1000:1000 /run/user/1000 # Set owner
	sudo chmod 700 /run/user/1000       # change the Permissions
	echo 'tmpfs /run/user/1000 tmpfs size=4G,mode=700,uid=1000,gid=1000 0 0' | sudo tee -a /etc/fstab
	d /run/user/1000 0700 softeng softeng 4G
	sudo systemd-tmpfiles --create
	mkdir -p /run/user/"$(id -u)"
	export XDG_RUNTIME_DIR
	XDG_RUNTIME_DIR=/run/user/"$(id -u)"
	df -h /run/user/1000 /run/user/1000 # check if it's a tmpfs
	# you must reboot and recheck if your modifications still exist or its gone
}

# ------------------------- #
# update the packages again #
# ------------------------- #
update_packages

# --------------------- #
# Clear Temporary Files #
# --------------------- #
sudo rm -rf /tmp/*

# regenerate your initramfs
sudo mkinitcpio -P
echo 'Installation	Completed!'
echo 'Done!'
