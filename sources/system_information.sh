#!/usr/bin/env bash
# ------------------------------------------------------ #
# Get and Show PC Information, like (RAM,CPU,OS, ETC...) #
# ------------------------------------------------------ #
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
PARAM_COLOR="\033[0;36m" # Cyan for parameter names
VALUE_COLOR="\033[0;37m" # White for parameter values
RESET="\033[0m"          # Reset color
# --------------------------------------------------------
# Function to get & show system information
get_system_info() {
  # Show the current user
  echo "${PARAM_COLOR}User:${RESET} $(whoami)"
  # Display the operating system and distribution name
  echo "${PARAM_COLOR}OS (Distro):${RESET} $(cat </etc/os-release | grep -w NAME | cut -d= -f2)"
  # Print the kernel release version
  echo "${PARAM_COLOR}Kernel:${RESET} $(uname -r)"
  # Show the system uptime
  echo "${PARAM_COLOR}Uptime:${RESET} $(uptime -p)"
  # Display the window manager name
  echo "${PARAM_COLOR}Window Manager:${RESET} $(wmctrl -m | grep Name | cut -d: -f2)"
  # Show the current desktop environment
  echo "${PARAM_COLOR}Desktop Environment:${RESET} $XDG_CURRENT_DESKTOP"
  # Display the current shell
  echo "${PARAM_COLOR}Shell:${RESET} $SHELL"
  # Show the terminal type
  echo "${PARAM_COLOR}Terminal:${RESET} $(ps -p $$ | tail -1 | awk '{print $4}')"
  # Count the number of installed packages
  echo "${PARAM_COLOR}Packages:${RESET} $(pacman -Q | wc -l)"
  # Show CPU model
  echo "${PARAM_COLOR}CPU:${RESET} $(lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^[ \t]*//')"
  # Show CPU Usage
  echo "${PARAM_COLOR}CPU Usage:${RESET} $(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print 100 - $1"%"}')"
  # # Show CPU MAX Frequency
  echo "${PARAM_COLOR}CPU MAX Frequency:${RESET} $(lscpu | grep 'max MHz' | awk '{print $4}')" MHz
  echo "${PARAM_COLOR}GPU:${RESET} $(lspci | grep -i vga | cut -d: -f3 | sed 's/^[ \t]*//')"
  echo "${PARAM_COLOR}CPU Temp:${RESET} $(sensors | grep 'Package id 0:' | awk '{print $4}')"
  # Print the current date and time
  echo "${PARAM_COLOR}Date(Time):${RESET} $(date)"
  echo "${PARAM_COLOR}Local IPv4:${RESET} $(ip -o -4 addr show | awk '{print $4}' | cut -d/ -f1)"
  # Show external IPv4 address
  echo "${PARAM_COLOR}External IPv4:${RESET} $(curl -s ifconfig.me)"
  # Display used and total memory (RAM)
  echo "${PARAM_COLOR}Memory (RAM):${RESET} $(free -h | grep Mem | awk '{print $3 " / " $2}')"
  # Show firewall status
  echo "${PARAM_COLOR}Firewall:${RESET} $(sudo ufw status)"
  #! List system users
  echo "${PARAM_COLOR}System Users:${RESET} $(cut -d: -f1 /etc/passwd)"
  # Display the current session type (Wayland or X11)
  echo "${PARAM_COLOR}Session type:${RESET} $(XDG_SESSION_TYPE)"
  # Show system boot time
  echo "${PARAM_COLOR}System Boot Time:${RESET} $(who -b)"
  # Show detailed information about graphics devices and their drivers
  echo "${PARAM_COLOR}Graphics Devices:${RESET} $(lspci -k | grep -EA3 'VGA|3D|Display')"
  echo "${PARAM_COLOR}Graphics Devices:${RESET} $(lspci -k | grep -A 2 -E '(VGA|3D)')"
  # Display the currently running display manager (gdm, sddm, etc.)
  systemd-analyze blame | grep -E 'gdm|sddm|lightdm|xdm|lxdm' | head -n1 | awk '{print $2}' | sed 's/\.service//'
  # Show CPU temperature
  echo "${PARAM_COLOR}CPU Temperature:${RESET} $(sensors | grep 'temp1:' | awk '{print $2}')"
  # Display CPU usage percentage
  top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
  # Display CPU vendor
  lscpu | grep 'Vendor ID' | cut -d: -f2 | sed 's/^[ \t]*//'
  # Show the number of CPU cores
  lscpu | grep '^CPU(s):' | awk '{print $2}'
  # Display the number of cores per socket
  lscpu | grep 'Core(s) per socket' | awk '{print $4}'
  # Show the number of threads per core
  lscpu | grep 'Thread(s) per core' | awk '{print $4}'
  # Show the GPU information
  lspci | grep -i vga | cut -d: -f3 | sed 's/^[ \t]*//'
  # Show local IPv4 address
  hostname -I | awk '{print $1}'
  # List currently running services
  systemctl list-units --type=service --state=running | grep running
  # Show screen resolution
  xdpyinfo | grep dimensions | awk '{print $2}'
  # Display network interfaces and their addresses
  ip -o -4 addr show | awk '{print $2, $4}'
  # Show used and total swap space
  free -h | grep Swap | awk '{print $3 " / " $2}'
  # Display total disk space used and available
  df -h --total | grep total | awk '{print $3 " / " $2}'
  # Show used and available space on root partition
  df -h / | awk '{print $3 " / " $2}' | tail -n 1
  # Show used and available space on /home partition
  df -h /home | awk '{print $3 " / " $2}' | tail -n 1
  # Display system architecture
  uname -m
  # Show detailed kernel version and system information
  uname -a
  # List top 10 memory consuming processes
  ps aux --sort=-%mem | head -n 10
  # Show disk partitions and usage
  lsblk
  # Check for available updates
  checkupdates
  # Display open network ports and services
  ss -tuln
  # Show battery status
  upower -i "$(upower -e | grep BAT)"
  # Display temperature sensor readings
  sensors
  # List top 10 memory consuming processes (duplicate)
  ps aux --sort=-%mem | head -n 10
  # List top 10 CPU consuming processes
  ps aux --sort=-%cpu | head -n 10
}
# Get system information and store it in an array
# IFS=$'\n' read -d '' -r -a results <<<"$(get_system_info)"
# echo -e "${results[0]}"
