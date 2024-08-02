#!/usr/bin/env bash
# ----------------------
# hyprland AGS Top Bar
# ----------------------

# -------------------------------
# show internet speed on AGS bar
# -------------------------------
# Install Necessary Tools:
sudo pacman -S --noconfirm wget curl awk speedtest-cli
# Create a script file, e.g., ~/scripts/internet_speed.sh:
mkdir -p ~/scripts
tee ~/scripts/internet_speed.sh <<EOF >/dev/null
#!/bin/bash
download_speed=$(speedtest-cli --simple | grep 'Download:' | awk '{print $2 " " $3}')
upload_speed=$(speedtest-cli --simple | grep 'Upload:' | awk '{print $2 " " $3}')
echo "Download: $download_speed, Upload: $upload_speed"
EOF

chmod +x ~/scripts/internet_speed.sh
