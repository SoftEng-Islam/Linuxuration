#!/bin/sh
# -----------------------------------------------
# PC INFO (CPU,GPU,RAM,ETC...) to Variables
# -----------------------------------------------
# User
# OS (Distro)
# Kernal
# uptime
# Window Manager
# Desktop Environment
# Shell
# Terminal
# Packages
# CPU
# CPU Usage
# CPU Frequency
# CPU Model
# CPU Vendor
# CPU Cores
# CPU Cores Per Socket
# CPU Cores Per Core
# CPU Cores Per Thread
# CPU Cores Per Physical Core
# GPU
# CPU temp
# Date(Time)
# Local IPv4
# External IPv4
# Services
# Memory(RAM)
# Resulation
# Network
# Swap
# Disk Space
# Storage /
# Storage /home

echo "# User"
whoami

echo "# OS (Distro)"
cat /etc/os-release | grep -w NAME | cut -d= -f2

echo "# Kernel"
uname -r

echo "# Uptime"
uptime -p

echo "# Window Manager"
wmctrl -m | grep Name | cut -d: -f2

echo "# Desktop Environment"
echo $XDG_CURRENT_DESKTOP

echo "# Shell"
echo $SHELL

echo "# Terminal"
ps -p $$ | tail -1 | awk '{print $4}'

echo "# Packages"
pacman -Q | wc -l

echo "# CPU"
lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^[ \t]*//'

echo "# CPU Usage"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'

echo "# CPU Frequency"
lscpu | grep 'MHz' | head -1 | awk '{print $3 " MHz"}'

echo "# CPU Model"
lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^[ \t]*//'

echo "# CPU Vendor"
lscpu | grep 'Vendor ID' | cut -d: -f2 | sed 's/^[ \t]*//'

echo "# CPU Cores"
lscpu | grep '^CPU(s):' | awk '{print $2}'

echo "# CPU Cores Per Socket"
lscpu | grep 'Core(s) per socket' | awk '{print $4}'

echo "# CPU Threads Per Core"
lscpu | grep 'Thread(s) per core' | awk '{print $4}'

echo "# GPU"
lspci | grep -i vga | cut -d: -f3 | sed 's/^[ \t]*//'

echo "# CPU Temp"
sensors | grep 'Package id 0:' | awk '{print $4}'

echo "# Date(Time)"
date

echo "# Local IPv4"
hostname -I | awk '{print $1}'

echo "# External IPv4"
curl -s ifconfig.me

echo "# Services"
# systemctl list-units --type=service --state=running | grep running

echo "# Memory (RAM)"
free -h | grep Mem | awk '{print $3 " / " $2}'

echo "# Resolution"
xdpyinfo | grep dimensions | awk '{print $2}'

echo "# Network"
ip -o -4 addr show | awk '{print $2, $4}'

echo "# Swap"
free -h | grep Swap | awk '{print $3 " / " $2}'

echo "# Disk Space"
df -h --total | grep total | awk '{print $3 " / " $2}'

echo "# Storage /"
df -h / | awk '{print $3 " / " $2}' | tail -n 1

echo "# Storage /home"
df -h /home | awk '{print $3 " / " $2}' | tail -n 1

echo "# Architecture"
uname -m

echo "# Kernel Version and Info"
uname -a

echo "# Current Running Processes"
# ps aux --sort=-%mem | head -n 10

echo "# Disk Partitions and Usage"
lsblk

echo "# Available Updates"
checkupdates

echo "# Mounted File Systems"
mount | column -t

echo "# Open Ports and Services"
ss -tuln

echo "# Battery Status"
upower -i $(upower -e | grep BAT)

echo "# Temperature Sensors"
sensors

echo "# Top Memory Consuming Processes"
# ps aux --sort=-%mem | head -n 10

echo "# Top CPU Consuming Processes"
# ps aux --sort=-%cpu | head -n 10

echo "# System Boot Time"
who -b

echo "# Active Network Connections"
# netstat -tuln

echo "# Firewall Status"
# sudo ufw status

echo "# List of Users"
# cut -d: -f1 /etc/passwd

echo "# Groups and Users in Each Group"
# getent group
