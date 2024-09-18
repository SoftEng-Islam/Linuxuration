#!/bin/bash
# A bash script designed to run only once dotfiles installed

# THIS SCRIPT CAN BE DELETED ONCE SUCCESSFULLY BOOTED!! And also, edit ~/.config/hypr/configs/Settings.conf
# not necessary to do since this script is only designed to run only once as long as the marker exists
# However, I do highly suggest not to touch it since again, as long as the marker exist, script wont run

# Variables
scriptsDir=$HOME/.config/hypr/scripts
wallpaper=$HOME/.config/hypr/wallpaper_effects/.wallpaper_modified
kvantum_theme="Catppuccin-Mocha"
color_scheme="prefer-dark"
gtk_theme="Default"
icon_theme="Papirus"
# cursor_theme="Bibata-Modern-Ice"

swww="swww img"
effect="--transition-bezier .43,1.19,1,.4 --transition-fps 30 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2"

# Check if a marker file exists.
if [ ! -f ~/.config/hypr/.initial_startup_done ]; then
	sleep 1
	# Initialize wallust and wallpaper
	if [ -f "$wallpaper" ]; then
		wallust run -s "$wallpaper" >/dev/null
		swww query || swww-daemon && $swww "$wallpaper" "$effect"
		"$scriptsDir/WallustSwww.sh" >/dev/null 2>&1 &
	fi

	# initiate GTK dark mode and apply icon and cursor theme
	gsettings set org.gnome.desktop.interface color-scheme $color_scheme >/dev/null 2>&1 &
	gsettings set org.gnome.desktop.interface gtk-theme $gtk_theme >/dev/null 2>&1 &
	gsettings set org.gnome.desktop.interface icon-theme $icon_theme >/dev/null 2>&1 &
	# gsettings set org.gnome.desktop.interface cursor-theme $cursor_theme >/dev/null 2>&1 &
	gsettings set org.gnome.desktop.interface cursor-size 24 >/dev/null 2>&1 &

	# initiate kvantum theme
	kvantummanager --set "$kvantum_theme" >/dev/null 2>&1 &

	# initiate the kb_layout (for some reason)
	"$scriptsDir/SwitchKeyboardLayout.sh" >/dev/null 2>&1 &

	# Create a marker file to indicate that the script has been executed.
	touch ~/.config/hypr/.initial_startup_done

	exit
fi
