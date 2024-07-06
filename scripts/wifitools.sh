#!/bin/bash

# This script can install hashcat & hcxdumptool & hcxtools


cd ~/Downloads/
git clone https://github.com/ZerBea/hcxdumptool.git
cd hcxdumptool
make -j $(nproc)
sudo make install