#!/usr/bin/env bash
# ------------------------------------------------------ #
# Get and Show PC Information, like (RAM,CPU,OS, ETC...) #
# ------------------------------------------------------ #
# Declare Variables
# 	Colors

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

# Check loaded kernel modules related to AMD GPUs
lsmod | grep amdgpu

# Display the current session type (Wayland or X11)
echo "$XDG_SESSION_TYPE"

# Show detailed information about graphics devices and their drivers
lspci -k | grep -EA3 'VGA|3D|Display'

# Alternative to show graphics devices and their drivers
lspci -k | grep -A 2 -E "(VGA|3D)"

# Display the currently running display manager (gdm, sddm, etc.)
systemd-analyze blame | grep -E 'gdm|sddm|lightdm|xdm|lxdm' | head -n1 | awk '{print $2}' | sed 's/\.service//'

# Show the current user
whoami

# Display the operating system and distribution name
cat /etc/os-release | grep -w NAME | cut -d= -f2

# Print the kernel release version
uname -r

# Show the system uptime
uptime -p

# Display the window manager name
wmctrl -m | grep Name | cut -d: -f2

# Show the current desktop environment
echo "$XDG_CURRENT_DESKTOP"

# Display the current shell
echo "$SHELL"

# Show the terminal type
ps -p $$ | tail -1 | awk '{print $4}'

# Count the number of installed packages
pacman -Q | wc -l

# Display CPU model name
lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^[ \t]*//'

# Show CPU temperature
sensors | grep 'Package id 0:' | awk '{print $4}'

# Display CPU usage percentage
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'

# Show CPU frequency
lscpu | grep 'MHz' | head -1 | awk '{print $3 " MHz"}'

# Show CPU model
lscpu | grep 'Model name' | cut -d: -f2 | sed 's/^[ \t]*//'

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

# Print the current date and time
date

# Show local IPv4 address
hostname -I | awk '{print $1}'

# Show external IPv4 address
curl -s ifconfig.me

# List currently running services
systemctl list-units --type=service --state=running | grep running

# Display used and total memory (RAM)
free -h | grep Mem | awk '{print $3 " / " $2}'

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

# List mounted file systems
mount | column -t

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

# Show system boot time
who -b

# Display active network connections
netstat -tuln

# Show firewall status
sudo ufw status

# List system users
cut -d: -f1 /etc/passwd

# Show groups and users in each group
getent group

# Function to get & show system information
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
	echo "${PARAM_COLOR}CPU Frequency:${RESET} $(lscpu | grep 'max MHz' | awk '{print $4}')" MHz
	echo "${PARAM_COLOR}GPU:${RESET} $(lspci | grep -i vga | cut -d: -f3 | sed 's/^[ \t]*//')"
	echo "${PARAM_COLOR}CPU Temp:${RESET} $(sensors | grep 'Package id 0:' | awk '{print $4}')"
	echo "${PARAM_COLOR}Date(Time):${RESET} $(date)"
	echo "${PARAM_COLOR}Local IPv4:${RESET} $(ip -o -4 addr show | awk '{print $4}' | cut -d/ -f1)"
	echo "${PARAM_COLOR}External IPv4:${RESET} $(curl -s ifconfig.me)"
	echo "${PARAM_COLOR}Memory (RAM):${RESET} $(free -h | grep Mem | awk '{print $3 " / " $2}')"
}

# Get system information and store it in an array
IFS=$'\n' read -d '' -r -a results <<<"$(get_system_info)"

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
echo -e "${PURPLE}      ######; - - ;#####"
echo -e "${PURPLE}     #######|  *  |######"
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
