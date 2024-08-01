#!/bin/bash
# =========================================================
# This script can install hashcat & hcxdumptool & hcxtools
# =========================================================

# -----------------------------------------------------------
# Install hcxdumptool
# https://github.com/ZerBea/hcxdumptool
# Small tool to capture packets from wlan devices.
# -----------------------------------------------------------
cd ~/Downloads/
git clone https://github.com/ZerBea/hcxdumptool.git
cd hcxdumptool
make -j $(nproc)
sudo make install

# -----------------------------------------------------------
# Install hcxtools
# https://github.com/ZerBea/hcxtools
# A small set of tools to convert packets from capture files to hash files for use with Hashcat or John the Ripper.
# -----------------------------------------------------------
cd ~/Downloads/
git clone https://github.com/ZerBea/hcxtools.git
cd hcxtools
make -j $(nproc)
sudo make install

# -----------------------------------------------------------
# Install Hashcat
# https://hashcat.net/hashcat/
# https://github.com/hashcat/hashcat
# World's fastest and most advanced password recovery utility
# -----------------------------------------------------------
