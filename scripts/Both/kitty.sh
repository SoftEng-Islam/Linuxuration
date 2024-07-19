#!/bin/bash
# -------------------------
# Kitty Terminal Emulator
# https://sw.kovidgoyal.net/kitty
# -------------------------
echo 'Install Kitty terminal emulator'
sudo pacman -S --noconfirm kitty
echo 'Set Kitty as the Default Terminal:'
export TERMINAL=kitty
# Kitty's configuration file can be found at ~/.config/kitty/kitty.conf.
# You can customize Kitty's appearance and behavior by editing this file.
