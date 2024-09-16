#!/bin/bash

sudo pacman -S cmake ninja
git clone https://github.com/hyprland-community/hyprspace
cd hyprspace && mkdir build
cd build && cmake -G Ninja ..
ninja && sudo ninja install

# Configure Hyprspace in Hyprland
# Now that the plugin is installed,
# you’ll need to modify your Hyprland configuration file (typically located at
#  ~/.config/hypr/hyprland.conf) to load the Hyprspace plugin.
# Add the following line to your Hyprland configuration under the plugins section (if it exists) or create a new section for plugins:

echo "plugin=hyprspace" >>~/.config/hypr/hyprland.conf

# Restart Hyprland
hyprctl dispatch exit

# Check if the Plugin is Loaded
hyprctl plugins

#!/bin/bash

# Hyprland configuration file path
HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"

# Check if the file exists
if [ ! -f "$HYPRLAND_CONF" ]; then
	echo "Hyprland configuration file not found at $HYPRLAND_CONF"
	exit 1
fi

# Check if there is a [plugins] section in the configuration file
if grep -q "^\[plugins\]" "$HYPRLAND_CONF"; then
	echo "[plugins] section found in $HYPRLAND_CONF"

	# Check if 'plugin=hyprspace' is already in the [plugins] section
	if grep -q "^plugin=hyprspace" "$HYPRLAND_CONF"; then
		echo "Hyprspace plugin is already configured in the [plugins] section"
	else
		# Append 'plugin=hyprspace' to the [plugins] section
		echo "Adding Hyprspace plugin to the [plugins] section"
		sed -i '/^\[plugins\]/a plugin=hyprspace' "$HYPRLAND_CONF"
		echo "Hyprspace plugin added successfully!"
	fi
else
	# No [plugins] section found, so create one and add the plugin
	echo "No [plugins] section found, creating one."
	echo -e "\n[plugins]\nplugin=hyprspace" >>"$HYPRLAND_CONF"
	echo "Hyprspace plugin and [plugins] section added successfully!"
fi
