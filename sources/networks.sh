#!/usr/bin/env bash
# ------------------------------------------ #
# Enhancements for Network & WIFI & Internet #
# ------------------------------------------ #
#* https://wiki.archlinux.org/index.php/NetworkManager
#* https://wiki.archlinux.org/index.php/WireGuard
# ------------------------------------------ #

# --------------- #
# Create log file #
# --------------- #
sudo touch /var/log/networks.log
LOGFILE="/var/log/networks.log"
log() { echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a $LOGFILE >/dev/null; }

error_exit() {
	log "Error: $1" && exit 1
}

# --------------------------------------- #
# Change these variables to true or false #
# --------------------------------------- #
install_cloudflare_warp=true        # Install Cloudflare WARP
install_networks_packages=true      # Install Important Packages
restore_hosts=true                  # restore default /etc/hosts
restore_host_conf=true              # restore default /etc/host.conf
prevent_overwriting_resolv=true     # prevent overwriting of /etc/resolv.conf
disable_firewalld=true              # Disable Firewall
save_iptables_rules=true            # Save iptables rules
install_hcxdumptool=true            # Install hcxdumptool
install_hcxtools=true               # Install hcxtools
verify_router_gateway=true          # Verify Router Gateway
verifying_network_connectivity=true # Verifying Network Connectivity
verifying_dns_resolution=true       # Verifying DNS Resolution

# -------------------------- #
# Install Important Packages #
# -------------------------- #
log "Installing important packages..."
echo "Installing important network packages..."
if [[ "$install_networks_packages" == true ]]; then
	packages=( # an Array of Packages that related to networks to Install
		"firewalld" # Firewall service
		"networkmanager"
		"wpa_supplicant"
		"dhclient"
		"iw"
		"wireless_tools"
		"dialog"
		"dnsmasq"
		"hostapd"
		"nm-connection-editor"
		"dhcpcd"
		"network-manager-applet"
		"netctl"
		"networkmanager-openvpn"
		"wireguard-tools"
		"qrencode"
		"xdg-utils"
		"traceroute"
		"nmap"
		"bind"
		"nftables"
		"linux-atm"
		"ifplugd"
		"openvswitch"
		"cppzmq"
		"pacrunner"
	)
	sudo pacman -S --noconfirm "${packages[@]}"
	echo "Networks packages installed!"
fi

# ----------------------- #
# Install Cloudflare WARP #
# ----------------------- #
# This might help you bypass your ISP’s restrictions and provide a faster internet
if [[ "$install_cloudflare_warp" == true ]]; then
	echo "Installing Cloudflare WARP..."
	yay -S --needed --noconfirm cloudflare-warp-bin
	sudo systemctl enable warp-svc --now
	echo "Cloudflare WARP has been installed and the service is running."
	# Disable it if you faced issues
	# sudo systemctl disable warp-svc --now
fi

# -----------------------------------------------------------
# This script can install hashcat & hcxdumptool & hcxtools
# -----------------------------------------------------------
# Install hcxdumptool
# https://github.com/ZerBea/hcxdumptool
# Small tool to capture packets from wlan devices.
# -----------------------------------------------------------
if [[ "$install_hcxdumptool" == true ]]; then
	cd ~/Downloads/ || exit
	git clone https://github.com/ZerBea/hcxdumptool.git
	cd hcxdumptool || exit
	make -j "$(nproc)"
	sudo make install
fi

# -----------------------------------------------------------
# Install hcxtools
# https://github.com/ZerBea/hcxtools
# A small set of tools to convert packets from capture files to hash files for use with Hashcat or John the Ripper.
# -----------------------------------------------------------
if [[ "$install_hcxtools" == true ]]; then
	cd ~/Downloads/ || echo "can't find ~/Downloads/ directory"
	git clone https://github.com/ZerBea/hcxtools.git
	cd hcxtools || exit
	make -j "$(nproc)"
	sudo make install
fi

# -----------------------------------------------------------
# Install Hashcat
# https://hashcat.net/hashcat/
# https://github.com/hashcat/hashcat
# World's fastest and most advanced password recovery utility
# -----------------------------------------------------------

# ------------------------------------------------------------------- #
# Disable NetworkManager to prevent interference during configuration #
# ------------------------------------------------------------------- #
log "Disabling NetworkManager..."
sudo systemctl disable --now NetworkManager
# To Enable run this command:
# sudo systemctl enable --now NetworkManager

# ------------------------------- #
# Restore Default /etc/hosts File #
# ------------------------------- #
if [[ "$restore_hosts" == true ]]; then
	log "Restoring default /etc/hosts file..."
	sudo tee /etc/hosts <<EOF >/dev/null
127.0.0.1   localhost
::1         localhost
127.0.1.1   $(hostname).localdomain $(hostname)
EOF
fi

# ----------------------------------- #
# Restore Default /etc/host.conf File #
# ----------------------------------- #
if [[ "$restore_host_conf" == true ]]; then
	log "Restoring default /etc/host.conf file..."
	sudo tee /etc/host.conf <<EOF >/dev/null
# The "order" line is only used by old versions of the C library.
order hosts,bind
multi on
EOF
fi

# --------------------------------------- #
# Prevent Overwriting of /etc/resolv.conf #
# --------------------------------------- #
# This prevents your system from overwriting your DNS settings with the system's DNS settings.
# This is useful if you want to use a DNS server other than the system's DNS server.
if [[ "$prevent_overwriting_resolv" == true ]]; then
	log "Preventing overwriting of /etc/resolv.conf..."
	sudo tee /etc/resolv.conf <<EOF >/dev/null
	nameserver 127.0.0.1
EOF
	sudo chattr +i /etc/resolv.conf
fi

# ------------------------------- #
# Disable Wi-Fi power-saving mode #
# ------------------------------- #
if [[ "$disable_wifi_saving" == true ]]; then
	log "Disabling Wi-Fi power-saving mode..."
	sudo tee /etc/NetworkManager/NetworkManager.conf <<EOF >>/dev/null
[connection]
wifi.powersave = 2
EOF
fi

# -------------- #
# Disabling IPv6 #
# -------------- #
if [[ "$disable_ipv6" == true ]]; then
	log "Disabling IPv6..."
	sudo tee /etc/sysctl.d/ipv6.conf <<EOF >/dev/null
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.eth0.disable_ipv6 = 1
EOF
fi

# ---------------------- #
# Adjust TCP/IP Settings #
# ---------------------- #
if [[ "$adjusting_TCP_IP" == true ]]; then
	log "Adjusting TCP/IP settings..."
	sudo rn -rf /etc/sysctl.d/99-sysctl.conf
	sudo touch /etc/sysctl.d/99-sysctl.conf
	sudo tee /etc/sysctl.d/99-sysctl.conf <<EOF >/dev/null
net.ipv4.ip_forward = 1
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
	# Set TCP Retries #
	sudo tee /etc/sysctl.conf <<EOF >/dev/null
net.ipv4.tcp_retries1 = 5
net.ipv4.tcp_retries2 = 15
EOF
	# Apply the changes
	sudo sysctl -p /etc/sysctl.conf && sudo sysctl -p /etc/sysctl.d/99-sysctl.conf
	# Enable IP Forwarding using sysctl
	sudo sysctl -w net.ipv4.ip_forward=1
fi

# -------------------- #
# Increase Buffer Size #
# -------------------- #
if [[ "$increase_buffer" == true ]]; then
	log "Increasing buffer size..."
	sudo sysctl -w net.core.rmem_max=16777216
	sudo sysctl -w net.core.wmem_max=16777216
fi

# ----------------- #
# Disable firewalld #
# ----------------- #
if [[ "$disable_firewalld" == true ]]; then
	sudo systemctl disable --now firewalld
fi

# --------------------- #
# Configure Firewall    #
# --------------------- #
if [[ "$configuring_firewall" == true ]]; then
	log "Configuring firewall..."
	sudo tee /etc/NetworkManager/conf.d/00-local.conf <<EOF >/dev/null
[main]
firewall-backend=none
EOF
fi

# ----------------------------- #
# Configuring Firewall Policies #
# ----------------------------- #
if [[ "$firewall_policies" == true ]]; then
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
fi

# ------------------- #
# Save iptables Rules #
# ------------------- #
if [[ "$save_iptables_rules" == true ]]; then
	log "Saving iptables rules..."
	sudo touch /etc/iptables/iptables.rules
	sudo chmod 644 /etc/iptables/iptables.rules
	sudo iptables-save | sudo tee /etc/iptables/iptables.rules
	sudo iptables -L
	sudo modprobe ip_tables
	sudo modprobe iptable_filter
	# -------------------------- #
	# Configure iptables for NAT #
	# -------------------------- #
	log "Configuring iptables for NAT..."
	sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
	sudo iptables -A FORWARD -i wlan0 -o eno1 -m state --state RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -i eno1 -o wlan0 -j ACCEPT
fi

# ------------------------ #
# Disable systemd-resolved #
# ------------------------ #
# dnsmasq is the Alternative for systemd-resolved
if [[ "$disable_systemd_resolved" == true ]]; then
	sudo systemctl stop systemd-resolved
	sudo systemctl disable --now systemd-resolved
	# sudo chattr -i /etc/resolv.conf
	# sudo rm -rf /etc/resolv.conf
fi

# ---------------------- #
# Configure dnsmasq.conf #
# ---------------------- #
if [[ "$configure_dnsmasq" == true ]]; then
	sudo tee /etc/dnsmasq.conf <<EOF >/dev/null
server 8.8.8.8
server 8.8.4.4
server 1.1.1.1
server 1.0.0.1
EOF
fi

# -------------------------------------------------- #
# Restart necessary services & enable and start them #
# -------------------------------------------------- #
log "Enabling and starting necessary services..."
services=(NetworkManager dnsmasq systemd-resolved iptables nftables firewalld)
for service in "${services[@]}"; do
	sudo systemctl enable --now "$service"
	sudo systemctl restart "$service"
done

# --------------------- #
# Verify Router/Gateway #
# --------------------- #
if [[ "$verify_router_gateway" == true ]]; then
	log "Verifying router/gateway..."
	echo "Verifying router/gateway..."
	ip route | grep default || error_exit "Default route (gateway) not found"
	GATEWAY=$(ip route | grep default | awk '{print $3}')
	ping -c 4 "$GATEWAY" || error_exit "Gateway test failed"
fi
# ------------------------------ #
# To Verify Network Connectivity #
# ------------------------------ #
if [[ "$verifying_network_connectivity" == true ]]; then
	log "Verifying network connectivity..."
	ping -c 4 8.8.8.8 || error_exit "Network connectivity test failed"
fi
# --------------------- #
# Verify DNS Resolution #
# --------------------- #
if [[ "$verifying_dns_resolution" == true ]]; then
	log "Verifying DNS resolution..."
	ping -c 4 google.com || error_exit "DNS resolution test failed"
fi

log "Network and Wi-Fi setup completed successfully."
echo "Done!"
