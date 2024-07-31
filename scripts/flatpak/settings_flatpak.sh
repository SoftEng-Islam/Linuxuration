#!/bin/bash
# ----------------------------------------
# Flatpak Enhancements
# ----------------------------------------
pacman -S flatpak --noconfirm
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# increase the timeout settings for Flatpak
FLATPAK_CONF="/etc/flatpak/flatpak.conf"
echo "[Network]" >>$FLATPAK_CONF
# Increase timeout settings (adjust as needed)
echo "RequestTimeout=800" >>$FLATPAK_CONF
echo "Timeout settings updated in $FLATPAK_CONF"
