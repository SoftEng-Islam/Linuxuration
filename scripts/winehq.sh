#!/bin/bash
# ------------------------------------
# Script To Install wineHQ
# ------------------------------------
: '
Wine (originally an acronym for "Wine Is Not an Emulator")
is a compatibility layer capable of running Windows
applications on several POSIX-compliant operating systems,
such as Linux, macOS, & BSD. Instead of simulating internal
Windows logic like a virtual machine or emulator,
Wine translates Windows API calls into POSIX calls
on-the-fly, eliminating the performance and memory penalties
of other methods and allowing you to cleanly integrate
Windows applications into your desktop.
'

# Install Wine and some essential dependencies:
sudo pacman -S --noconfirm wine winetricks wine-mono wine-gecko

# Once installed, you can configure Wine by running the Wine configuration tool:
winecfg

# Verify the Installation
wine --version

# PlayOnLinux: A graphical...
#..front-end for Wine that simplifies the installation and management of Windows applications:

# Install PlayOnLinux from AUR
yay -S --noconfirm playonlinux

# OR you can Install it by trizen:
# trizen -S playonlinux

# After installation, you can run PlayOnLinux by executing the following command:
playonlinux

# Examples:
# Running Windows Applications
# wine /path/to/your/application.exe

# Installing Notepad++
# wine npp.7.9.5.Installer.exe

# Troubleshooting
# If you encounter issues, here are some tips:
# Winetricks: Use winetricks to install missing libraries or components:
# winetricks
