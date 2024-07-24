#!/bin/bash

# ---------------------------------------- #
# To set microsoft edge as default Browser #
# ---------------------------------------- #
xdg-settings set default-web-browser microsoft-edge.desktop

# --------------------------------- #
# to get whats you default browser? #
# --------------------------------- #
xdg-settings get default-web-browser

# ------------------------------- #
# List all installed browsers #
# ------------------------------- #
ls /usr/share/applications | grep edge
