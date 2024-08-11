#!/bin/bash
sudo pacman -S --needed dos2unix --noconfirm
for script in "$@"; do
	echo "Cleaning $script..."
	# Remove non-ASCII characters
	sed -i 's/[\x80-\xFF]//g' "$script"
	# Convert line endings from CRLF to LF
	dos2unix "$script"
	# Remove BOM
	sed -i '1s/^\xEF\xBB\xBF//' "$script"
done

echo "Cleanup complete."
