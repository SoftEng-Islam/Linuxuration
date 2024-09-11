#!/bin/bash

# To fix the warning about missing console fonts
error_missing_console_fonts() {
	echo "Warning: Missing console fonts. Some features may not work correctly."
	if [ -f /etc/vconsole.conf ]; then
		echo "The file /etc/vconsole.conf exists."
		sudo tee /etc/vconsole.conf <<EOF >/dev/null
KEYMAP=us
FONT=lat9-16
EOF
	else
		echo "The file /etc/vconsole does not exist. Creating it."
		sudo touch /etc/vconsole.conf
		sudo tee /etc/vconsole.conf <<EOF >/dev/null
		KEYMAP=us
		FONT=lat9-16
EOF
	fi
}
# error_missing_console_fonts
