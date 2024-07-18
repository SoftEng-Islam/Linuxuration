#!/bin/bash

# ------------------------------------
# Gnome check-alive-timeout
# ------------------------------------
echo 'Disable Gnome check-alive-timeout'
gsettings set org.gnome.mutter check-alive-timeout 0
