#!/bin/bash
# -----------------------------------------
# Hyprland & Packages Installation Script
# https://wiki.hyprland.org/Getting-Started/Installation/
# -----------------------------------------

# ----------------------------------------------------------
# Install Manual (Manual Build): Hyprland and Dependencies
# ----------------------------------------------------------
yay -S --noconfirm gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprlang hyprcursor hyprwayland-scanner xcb-util-errors hyprland

# ----------------------------------------------------------
# CMake (recommended)
# ----------------------------------------------------------
# git clone --recursive https://github.com/hyprwm/Hyprland
cd ~/Downloads
wget -O Hyprland.zip https://github.com/hyprwm/Hyprland/archive/refs/heads/main.zip
unzip Hyprland.zip
cd Hyprland
make all && sudo make install

# ------------------------------
# Hyprland Themes and Configs
# ------------------------------
echo "## Theme & Configs setup ##"
# hyprctl reload

# Accessing the parameters
param1=$1
param2=$2

# main theme
if [ "$1" == "mainTheme" ]; then
  hyprctl --batch "\
  keyword general:border_size 4;\
  keyword general:gaps_out 40;\
  keyword general:gaps_in 20;\
  keyword general:col.active_border 0.9\
  keyword general:col.inactive_border 0.6"
fi

# Game Mode Theme
if [ "$1" == "gamemode" ]; then
  hyprctl --batch "\
  keyword general:border_size 0:\
  keyword decoration:drop_shadow 0;\
  keyword decoration:blur:enabled 0;\
  keyword general:gaps_in 0;\
  keyword general:gaps_out 0;\
  keyword general:border_size 1;\
  keyword decoration:rounding 0"
fi

# packages neeeded
hypr_package=(
  curl
  gawk
  git
  grim
  gvfs
  gvfs-mtp
  ImageMagick
  jq
  kitty
  kvantum
  nano
  network-manager-applet
  openssl
  pamixer
  pavucontrol
  pipewire-alsa
  pipewire-utils
  playerctl
  polkit-gnome
  python3-requests
  python3-pip
  python3-pyquery
  qt5ct
  qt6ct
  qt6-qtsvg
  rofi-wayland
  slurp
  swappy
  SwayNotificationCenter
  waybar
  wget2
  wl-clipboard
  wlogout
  xdg-user-dirs
  xdg-utils
  yad
  brightnessctl
  btop
  cava
  eog
  fastfetch
  gnome-system-monitor
  mousepad
  mpv
  mpv-mpris
  nvtop
  qalculate-gtk
  vim-enhanced
)

copr_packages=(
  aylurs-gtk-shell
  cliphist
  hypridle
  hyprlock
  pamixer
  pyprland
  swww
)

# List of packages to uninstall as it conflicts with swaync or causing swaync to not function properly
uninstall=(
  dunst
  mako
)

# ## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# # Determine the directory where the script is located
# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# # Change the working directory to the parent directory of the script
# PARENT_DIR="$SCRIPT_DIR/.."
# cd "$PARENT_DIR" || exit 1

# source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"

# # Set the name of the log file to include the current date and time
# LOG="Install-Logs/install-$(date +%d-%H%M%S)_hypr-pkgs.log"

# # Installation of main components
# printf "\n%s - Installing hyprland packages.... \n" "${NOTE}"

# for PKG1 in "${hypr_package[@]}" "${hypr_package_2[@]}" "${copr_packages[@]}" "${Extra[@]}"; do
#   install_package "$PKG1" 2>&1 | tee -a "$LOG"
#   if [ $? -ne 0 ]; then
#     echo -e "\e[1A\e[K${ERROR} - $PKG1 Package installation failed, Please check the installation logs"
#     exit 1
#   fi
# done

# # removing dunst and mako to avoid swaync conflict
# printf "\n%s - Checking if mako or dunst are installed and removing for swaync to work properly \n" "${NOTE}"

# for PKG in "${uninstall[@]}"; do
#   uninstall_package "$PKG" 2>&1 | tee -a "$LOG"
#   if [ $? -ne 0 ]; then
#     echo -e "\e[1A\e[K${ERROR} - $PKG uninstallation had failed, please check the log"
#     exit 1
#   fi
# done

# clear
