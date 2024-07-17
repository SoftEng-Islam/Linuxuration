#!/bin/bash
# -----------------------------------------------
# Options for User
# 1= true or Enable or Install or add
# 0= false or Disable or don't install
# -----------------------------------------------

echo 'Select your Options:'
# Install Or Improve Gnome
gnome=1
# Install Or Improve Hyprland
hyprland=1
# Install Themes
themes=1
# Install Icons
icons=1

# ----------------------------------------------------------
# Install Apps, 1 will install the enabled apps or app=1
apps=1

## Install LibreOffice
LibreOffice=1 # if apps=1 this means to install LibreOffice
## Install Brave Browser
Brave=0
## Install Slack
Slack=1
## Install Discord
Discord=1
## Install Spotify
Spotify=0
## Install Visual Studio Code
VisualStudioCode=1
## Install Sublime Text
SublimeText=0
## Install Atom
Atom=0
## Install Emacs
Emacs=0

# ----------------------------------------------------
# Install Fonts
fonts=1
## Install Nerd Fonts
NerdFonts=1

# Install Drivers
drivers=1
# Install Tools & Languages for Developers
# Install Wine To Run Windows apps and games
wineHQ=1
# --------------------------------------------------
# Install ZSH & OH-MY-ZSH
## Install ZSH
ZSH=1
OH-MY-ZSH=1

# Install Pomodoro
Pomodoro=1

# Install plymouth-themes
plymouth=1

# -------------------------------------------------------------
# Check if the User want to Install or Improve Hyprland/themes
# -------------------------------------------------------------
if [ "$1" == 'hyprland' ]; then
    # Install Hyprland and Some Deps
fi

# ----------------------------------------------------------
# Check if the User want to Install or Improve Gnome/themes
# ----------------------------------------------------------
if [ "$1" == 'gnome' ]; then
    # Install Gnome and Some Deps
fi
