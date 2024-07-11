#!/bin/bash
# =================================================
# Install trizen
# =================================================

: '
------------------------------------------------------------------------
Trizen is an AUR (Arch User Repository) helper that simplifies the process of installing, updating, and managing AUR packages on Arch Linux.
AUR helpers like Trizen automate the process of downloading, building, and installing packages from the AUR,
making it easier for users to install software that isnt available in the official repositories.
------------------------------------------------------------------------
# Key Features of Trizen:
    Search AUR Packages: You can search for AUR packages by name or description.
    Install AUR Packages: Easily download, build, and install packages from the AUR.
    Update AUR Packages: Check for updates and install them for AUR packages you have installed.
    Dependencies Handling: Automatically resolves dependencies required by AUR packages.
    Interactive Interface: Offers an interactive mode to review and edit PKGBUILDs before building.
'

# Install trizen
cd ~/Downloads
git clone https://aur.archlinux.org/trizen.git
cd trizen
# Build and install Trizen
makepkg -si

: '
=======================================================
# Using Trizen:

## Search for a package:
    trizen -Ss <package_name>

## Install a package:
    trizen -S <package_name>

## Update all AUR packages:
    trizen -Syua

## Remove a package:
    trizen -R <package_name>

## View package information:
    trizen -Qi <package_name>
=======================================================
'
