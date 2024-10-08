#!/bin/bash

echo "Disable Gnome check-alive-timeout"
gsettings set org.gnome.mutter check-alive-timeout 0

echo "Remove window close and minimize buttons in GTK"
gsettings set org.gnome.desktop.wm.preferences button-layout ':'
