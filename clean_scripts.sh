#!/bin/bash

# Ensure dos2unix is installed
sudo pacman -S --needed dos2unix --noconfirm

# Process each script passed as argument
for script in "$@"; do
    echo "Cleaning $script..."

    # Remove non-ASCII characters using a more compatible approach
    LC_ALL=C sed -i 's/[^[:print:]\t]//g' "$script"

    # Convert line endings from CRLF to LF
    dos2unix "$script"

    # Remove BOM
    sed -i '1s/^\xEF\xBB\xBF//' "$script"
done

echo "Cleanup complete."
