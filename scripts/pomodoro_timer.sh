#!/usr/bin/env bash
# ----------------------------------------
# Install Pomodoro for Gnome & Hyprland
# ----------------------------------------

yay -S --noconfirm gnome-pomodoro

mkdir ~/.config/autostart/ && ~/.config/autostart/
# mkdir -p ~/.config/autostart

cat <<EOF >~/.config/autostart/pomodoro.desktop
[Desktop Entry]
Type=Application
Exec=gnome-pomodoro
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=GNOME Pomodoro
Name=GNOME Pomodoro
Comment[en_US]=Pomodoro timer for GNOME
Comment=Pomodoro timer for GNOME
EOF

# -------------------------------------
#  Configuring Hyprland for Notifications
# -------------------------------------
# To ensure that you receive notifications for your Pomodoro timer,
# make sure you have a notification daemon installed.
# dunst is a lightweight notification daemon that works well with Hyprland.
sudo pacman -S --noconfirm dunst

# Create a configuration file if it doesn't exist:
mkdir -p ~/.config/dunst
cp /usr/share/dunst/dunstrc ~/.config/dunst/dunstrc

# Start dunst by adding it to your Hyprland configuration file, typically ~/.config/hypr/hyprland.conf:
echo exec-once = dunst >>~/.config/hypr/hyprland.conf
# Restart Hyprland to apply the changes
hyprctl reload
