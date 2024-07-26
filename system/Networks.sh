#!/bin/bash
# ---------------------------------------------- #
# Here are some fixes for Network & WIFI & Internet  #
# ---------------------------------------------- #
# https://wiki.archlinux.org/index.php/NetworkManager
# https://wiki.archlinux.org/index.php/WireGuard
# ---------------------------------------------- #
# Features:
# Repair host.conf & hosts
# Repair iptables
# Repair firewalld
# Repair dnsmasq
# Repair NetworkManager
# Repair systemd-resolved
# Repair nm
# Repair nm-applet
# Repair nm-wireguard
# Repair nm-connection-editor
# Repair nm-openvpn
# ---------------------------------------------- #

LOGFILE="/var/log/network_repair.log"

log() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a $LOGFILE
}

error_exit() {
	log "Error: $1"
	exit 1
}

# ----------------- #
# Update The System #
# ----------------- #
log "Updating the system..."
sudo pacman --noconfirm -Syu || error_exit "Failed to update the system"
sudo pacman --noconfirm -S linux-firmware || error_exit "Failed to install linux-firmware"

# Install Cloudflare WARP
# This might help you bypass your ISP’s restrictions and provide a faster internet
# There will be a button on the right sidebar to toggle WARP if it’s installed
yay -S --noconfirm cloudflare-warp-bin && sudo systemctl enable warp-svc --now

# -------------------------- #
# Install Important Packages #
# -------------------------- #
log "Installing important packages..."
sudo pacman -S --noconfirm \
	firewalld \
	networkmanager \
	wpa_supplicant \
	dhclient \
	iw \
	wireless_tools \
	dialog \
	iptables \
	dnsmasq \
	hostapd \
	nm-connection-editor \
	connman \
	dhcpcd \
	network-manager-applet \
	netctl \
	networkmanager-openvpn \
	wireguard-tools \
	wireguard-dkms \
	qrencode \
	xdg-utils \
	traceroute \
	nmap \
	bind \
	python-nftables \
	nftables || error_exit "Failed to install packages"

# Disable NetworkManager to prevent interference during configuration
log "Disabling NetworkManager..."
sudo systemctl disable --now NetworkManager

# Restore Default /etc/hosts File
log "Restoring default /etc/hosts file..."
sudo tee /etc/hosts <<EOF >/dev/null
127.0.0.1   localhost
::1         localhost
127.0.1.1   $(hostname).localdomain $(hostname)
EOF

# Restore Default /etc/host.conf File
log "Restoring default /etc/host.conf file..."
sudo tee /etc/host.conf <<EOF >/dev/null
# The "order" line is only used by old versions of the C library.
order hosts,bind
multi on
EOF

# Prevent Overwriting of /etc/resolv.conf
log "Preventing overwriting of /etc/resolv.conf..."
sudo tee /etc/resolv.conf <<EOF >/dev/null
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 208.67.222.222
nameserver 208.67.220.220
EOF
sudo chattr +i /etc/resolv.conf

# Verify Network Connectivity
log "Verifying network connectivity..."
ping -c 4 8.8.8.8 || error_exit "Network connectivity test failed"

# Verify DNS Resolution
log "Verifying DNS resolution..."
ping -c 4 google.com || error_exit "DNS resolution test failed"

# Verify Router/Gateway
log "Verifying router/gateway..."
ip route | grep default || error_exit "Default route (gateway) not found"
GATEWAY=$(ip route | grep default | awk '{print $3}')
ping -c 4 $GATEWAY || error_exit "Gateway test failed"

# Configure Firewall
log "Configuring firewall..."
sudo tee /etc/NetworkManager/conf.d/00-local.conf <<EOF >/dev/null
[main]
firewall-backend=none
EOF

# Wi-Fi and Internet Configuration
log "Disabling Wi-Fi power-saving mode..."
sudo tee /etc/NetworkManager/NetworkManager.conf <<EOF >>/dev/null
[connection]
wifi.powersave = 2
EOF

log "Disabling IPv6..."
sudo tee /etc/sysctl.d/ipv6.conf <<EOF >/dev/null
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.eth0.disable_ipv6 = 1
EOF

# Firewall Policies
log "Configuring firewall policies..."
sudo firewall-cmd --permanent --get-policies

# Remove Existing Policies
sudo firewall-cmd --permanent --delete-policy=egress-shared
sudo firewall-cmd --permanent --delete-policy=ingress-shared

# Add New Policies
sudo firewall-cmd --permanent --new-policy=egress-shared
sudo firewall-cmd --permanent --policy=egress-shared --set-target=ACCEPT
sudo firewall-cmd --permanent --policy=egress-shared --add-ingress-zone=nm-shared
sudo firewall-cmd --permanent --policy=egress-shared --add-egress-zone=trusted
sudo firewall-cmd --permanent --policy=egress-shared --add-masquerade

sudo firewall-cmd --permanent --new-policy=ingress-shared
sudo firewall-cmd --permanent --policy=ingress-shared --set-target=ACCEPT
sudo firewall-cmd --permanent --policy=ingress-shared --add-ingress-zone=trusted
sudo firewall-cmd --permanent --policy=ingress-shared --add-egress-zone=nm-shared
sudo firewall-cmd --reload

# Configure iptables for NAT
log "Configuring iptables for NAT..."
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan0 -o eno1 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i eno1 -o wlan0 -j ACCEPT

# Save iptables Rules
sudo iptables-save >/etc/iptables/iptables.rules

# Enable IP Forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# Adjust TCP/IP Settings
log "Adjusting TCP/IP settings..."
sudo tee /etc/sysctl.d/99-sysctl.conf <<EOF >/dev/null
net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.core.netdev_max_backlog = 5000
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
EOF

# Apply the changes
sudo sysctl -p /etc/sysctl.d/99-sysctl.conf

# Set TCP Retries
sudo tee /etc/sysctl.conf <<EOF >/dev/null
net.ipv4.tcp_retries1 = 5
net.ipv4.tcp_retries2 = 15
EOF
# Apply the changes
sudo sysctl -p /etc/sysctl.conf

sudo sysctl -p

# Increase Buffer Size
log "Increasing buffer size..."
sudo sysctl -w net.core.rmem_max=16777216
sudo sysctl -w net.core.wmem_max=16777216

# Enable/Disable Services
log "Disabling unnecessary services..."
sudo systemctl disable --now avahi-daemon
sudo systemctl disable --now cups

log "Enabling and starting necessary services..."
services=(iptables firewalld dnsmasq NetworkManager systemd-resolved)
for service in "${services[@]}"; do
	sudo systemctl enable --now $service
	sudo systemctl restart $service
done

log "Network and Wi-Fi setup completed successfully."
