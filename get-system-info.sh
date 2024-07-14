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


# sudo pacman -S --noconfirm wmctrl inetutils lm_sensors curl


# Define colors
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

BRIGHT_BLACK="\033[1;30m"
BRIGHT_RED="\033[1;31m"
BRIGHT_GREEN="\033[1;32m"
BRIGHT_YELLOW="\033[1;33m"
BRIGHT_BLUE="\033[1;34m"
BRIGHT_PURPLE="\033[1;35m"
BRIGHT_CYAN="\033[1;36m"
BRIGHT_WHITE="\033[1;37m"



# Define colors for get_system_info
PARAM_COLOR="\033[0;36m"   # Cyan for parameter names
VALUE_COLOR="\033[0;37m"   # White for parameter values
RESET="\033[0m"            # Reset color

# Function to get system information
get_system_info() {
    echo "${PARAM_COLOR}User:${RESET} $(whoami)"
    echo "${PARAM_COLOR}OS (Distro):${RESET} $(cat /etc/os-release | grep -w NAME | cut -d= -f2)"
    echo "${PARAM_COLOR}Kernel:${RESET} $(uname -r)"
    echo "${PARAM_COLOR}Uptime:${RESET} $(uptime -p)"
    echo "${PARAM_COLOR}Window Manager:${RESET} $(wmctrl -m | grep Name | cut -d: -f2)"
    echo "${PARAM_COLOR}Desktop Environment:${RESET} $XDG_CURRENT_DESKTOP"
    echo "${PARAM_COLOR}Shell:${RESET} $SHELL"
    echo "${PARAM_COLOR}Terminal:${RESET} $(ps -p $$ | tail -1 | awk '{print $4}')"
    echo "${PARAM_COLOR}Packages:${RESET} $(pacman -Q | wc -l)"
    echo "${PARAM_COLOR}CPU:${RESET} $(lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^[ \t]*//')"
    echo "${PARAM_COLOR}CPU Usage:${RESET} $(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print 100 - $1"%"}')"
    echo "${PARAM_COLOR}CPU Frequency:${RESET} $(lscpu | grep 'MHz' | head -1 | awk '{print $3 " MHz"}')"
    echo "${PARAM_COLOR}GPU:${RESET} $(lspci | grep -i vga | cut -d: -f3 | sed 's/^[ \t]*//')"
    echo "${PARAM_COLOR}CPU Temp:${RESET} $(sensors | grep 'Package id 0:' | awk '{print $4}')"
    echo "${PARAM_COLOR}Date(Time):${RESET} $(date)"
    echo "${PARAM_COLOR}Local IPv4:${RESET} $(ip -o -4 addr show | awk '{print $4}' | cut -d/ -f1)"
    echo "${PARAM_COLOR}External IPv4:${RESET} $(curl -s ifconfig.me)"
    echo "${PARAM_COLOR}Memory (RAM):${RESET} $(free -h | grep Mem | awk '{print $3 " / " $2}')"
}


# Get system information and store it in an array
# IFS=$'\n' read -d '' -r -a results < <(get_system_info && printf '\0')

# Get system information and store it in an array
IFS=$'\n' read -d '' -r -a results <<< "$(get_system_info)"

# Display Arch Linux logo with system information
echo '-------------------------------------------------------------------'
echo -e "${PURPLE}               ."
echo -e "${PURPLE}               #"
echo -e "${PURPLE}              ###"
echo -e "${PURPLE}             #####"
echo -e "${PURPLE}             ######"
echo -e "${PURPLE}             #######"
echo -e "${PURPLE}            #########"
echo -e "${PURPLE}           ###########"
echo -e "${PURPLE}         ######.#####"
echo -e "${PURPLE}        ####### #######"
echo -e "${PURPLE}       #######   #######"
echo -e "${PURPLE}     .######; - - ;#####"
echo -e "${PURPLE}    .#######|  *  |######"
echo -e "${PURPLE}    ########.     .#######"
echo -e "${PURPLE}   ######'           '######"
echo -e "${PURPLE}  ;####                 ####;"
echo -e "${PURPLE}  ##'                     '##"
echo -e "${PURPLE} .'                         '."
echo -e "${RESET}"
echo '-------------------------------------------------------------------'
echo -e "${results[0]}"
echo -e "${results[2]}"
echo -e "${results[3]}"
echo -e "${results[4]}"
echo -e "${results[5]}"
echo -e "${results[6]}"
echo -e "${results[7]}"
echo -e "${results[8]}"
echo -e "${results[9]}"
echo -e "${results[10]}"
echo -e "${results[11]}"
echo -e "${results[12]}"
echo -e "${results[13]}"
echo -e "${results[14]}"
echo -e "${results[15]}"
echo -e "${results[16]}"
echo -e "${results[17]}"
echo -e "${results[18]}"

# ------------------------------------------------------

# echo "# User"
# whoami

# echo "# OS (Distro)"
# cat /etc/os-release | grep -w NAME | cut -d= -f2

# echo "# Kernel"
# uname -r

# echo "# Uptime"
# uptime -p

# echo "# Window Manager"
# wmctrl -m | grep Name | cut -d: -f2

# echo "# Desktop Environment"
# echo $XDG_CURRENT_DESKTOP

# echo "# Shell"
# echo $SHELL

# echo "# Terminal"
# ps -p $$ | tail -1 | awk '{print $4}'

# echo "# Packages"
# pacman -Q | wc -l

# echo "# CPU"
# lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^[ \t]*//'

# echo "# CPU Usage"
# top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'

# echo "# CPU Frequency"
# lscpu | grep 'MHz' | head -1 | awk '{print $3 " MHz"}'

# echo "# CPU Model"
# lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^[ \t]*//'

# echo "# CPU Vendor"
# lscpu | grep 'Vendor ID' | cut -d: -f2 | sed 's/^[ \t]*//'

# echo "# CPU Cores"
# lscpu | grep '^CPU(s):' | awk '{print $2}'

# echo "# CPU Cores Per Socket"
# lscpu | grep 'Core(s) per socket' | awk '{print $4}'

# echo "# CPU Threads Per Core"
# lscpu | grep 'Thread(s) per core' | awk '{print $4}'

# echo "# GPU"
# lspci | grep -i vga | cut -d: -f3 | sed 's/^[ \t]*//'

# echo "# CPU Temp"
# sensors | grep 'Package id 0:' | awk '{print $4}'

# echo "# Date(Time)"
# date

# echo "# Local IPv4"
# hostname -I | awk '{print $1}'

# echo "# External IPv4"
# curl -s ifconfig.me

# echo "# Services"
# # systemctl list-units --type=service --state=running | grep running

# echo "# Memory (RAM)"
# free -h | grep Mem | awk '{print $3 " / " $2}'

# echo "# Resolution"
# xdpyinfo | grep dimensions | awk '{print $2}'

# echo "# Network"
# ip -o -4 addr show | awk '{print $2, $4}'

# echo "# Swap"
# free -h | grep Swap | awk '{print $3 " / " $2}'

# echo "# Disk Space"
# df -h --total | grep total | awk '{print $3 " / " $2}'

# echo "# Storage /"
# df -h / | awk '{print $3 " / " $2}' | tail -n 1

# echo "# Storage /home"
# df -h /home | awk '{print $3 " / " $2}' | tail -n 1

# echo "# Architecture"
# uname -m

# echo "# Kernel Version and Info"
# uname -a

# echo "# Current Running Processes"
# # ps aux --sort=-%mem | head -n 10

# echo "# Disk Partitions and Usage"
# lsblk

# echo "# Available Updates"
# checkupdates

# echo "# Mounted File Systems"
# mount | column -t

# echo "# Open Ports and Services"
# ss -tuln

# echo "# Battery Status"
# upower -i $(upower -e | grep BAT)

# echo "# Temperature Sensors"
# sensors

# echo "# Top Memory Consuming Processes"
# # ps aux --sort=-%mem | head -n 10

# echo "# Top CPU Consuming Processes"
# # ps aux --sort=-%cpu | head -n 10

# echo "# System Boot Time"
# who -b

# echo "# Active Network Connections"
# # netstat -tuln

# echo "# Firewall Status"
# # sudo ufw status

# echo "# List of Users"
# # cut -d: -f1 /etc/passwd

# echo "# Groups and Users in Each Group"
# # getent group
