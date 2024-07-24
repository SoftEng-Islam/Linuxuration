#!/bin/bash

# ---------------------------------------- #
# To set microsoft edge as default Browser #
# ---------------------------------------- #
# xdg-settings set default-web-browser microsoft-edge.desktop
xdg-settings set default-web-browser com.microsoft.Edge.desktop

# --------------------------------- #
# to get whats you default browser? #
# --------------------------------- #
xdg-settings get default-web-browser

# ------------------------------- #
# List all installed browsers #
# ------------------------------- #
ls /usr/share/applications | grep edge
ls /var/lib/flatpak/exports/share/applications | grep edge
ls /var/lib/snapd/desktop/applications | grep edge

# ------------------------------- #
# To open a link in default browser #
# ------------------------------- #
xdg-open https://www.google.com

# ------------------------------- #
# To open a link in specific browser #
# ------------------------------- #
google-chrome https://www.google.com

# Update MIME Types (Optional)
# To ensure that all relevant MIME types are associated with Microsoft Edge, you can use the xdg-mime command:
xdg-mime default com.microsoft.Edge.desktop x-scheme-handler/http
xdg-mime default com.microsoft.Edge.desktop x-scheme-handler/https
xdg-mime default com.microsoft.Edge.desktop text/html
xdg-mime default com.microsoft.Edge.desktop application/xhtml+xml
xdg-mime default com.microsoft.Edge.desktop application/xml
xdg-mime default com.microsoft.Edge.desktop application/x-extension-htm
xdg-mime default com.microsoft.Edge.desktop application/x-extension-html
xdg-mime default com.microsoft.Edge.desktop application/x-extension-shtml
xdg-mime default com.microsoft.Edge.desktop application/x-extension-xht
xdg-mime default com.microsoft.Edge.desktop application/x-extension-xhtml
