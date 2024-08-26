#!/bin/bash
# ----------------------------------------
# Flatpak Enhancements
# ----------------------------------------
pacman -S flatpak --noconfirm
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# increase the timeout settings for Flatpak
FLATPAK_CONF="/etc/flatpak/flatpak.conf"
echo "[Network]" | sudo tee -a $FLATPAK_CONF > /dev/null
echo "RequestTimeout=1000" | sudo tee -a $FLATPAK_CONF > /dev/null
echo "Timeout settings updated in $FLATPAK_CONF"
