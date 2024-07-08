#!/bin/bash
# =========================================================
# This script can install hashcat & hcxdumptool & hcxtools
# =========================================================

# --------------------
# Install hcxdumptool
# https://github.com/ZerBea/hcxdumptool
# --------------------
cd ~/Downloads/
git clone https://github.com/ZerBea/hcxdumptool.git
cd hcxdumptool
make -j $(nproc)
sudo make install

# -----------------
# Install hcxtools
# https://github.com/ZerBea/hcxtools
# -----------------
cd ~/Downloads/
git clone https://github.com/ZerBea/hcxtools.git
cd hcxtools
make -j $(nproc)
sudo make install

# -----------------
# Install Hashcat
# -----------------
