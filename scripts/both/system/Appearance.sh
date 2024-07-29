#!/bin/bash

mkdir -p ~/.icons
mkdir -p ~/.themes
tar -xf "Bibata-Modern-Ice.tar.xz" -C ~/.icons

# tar -xzvf "theme/Andromeda-dark.tar.gz" -C ~/.themes
tar -xzvf "theme/WhiteSur-Lighttar.gz" -C ~/.themes
unzip -o -q "icon/Flat-Remix-Blue-Dark.zip" -d ~/.icons
unzip -o -q "icon/Flat-Remix-Blue-Light.zip" -d ~/.icons

# Function to update icon cache for a given directory
update_icon_cache() {
	local dir=$1
	if [ -d "$dir" ]; then
		echo "Updating icon cache for: $dir"
		sudo gtk-update-icon-cache "$dir"
	fi
}

# Update system-wide icon themes
for theme in /usr/share/icons/*; do
	update_icon_cache "$theme"
done

# Update user-specific icon themes
for theme in ~/.local/share/icons/*; do
	update_icon_cache "$theme"
done

# Update MIME database
echo "Updating MIME database..."
sudo update-mime-database /usr/share/mime

echo "Icon cache refresh complete."

# gsettings set org.gnome.desktop.interface icon-theme  youicons
