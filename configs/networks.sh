#!/bin/bash
# ---------------------------------------------- #
# Here some fixies for Network & WIFI & Internet #
# ---------------------------------------------- #
# Features:
# Repair host.conf & hosts
# Repair dnsmasq.conf
# Repair nm.conf
# Repair NetworkManager.conf
# Repair systemd-resolved.conf
#
# ---------------------------------------------- #

# ----------------- #
# Update The System #
# ----------------- #
sudo pacman --noconfirm -Syu
sudo pacman --noconfirm -S linux-firmware

# -------------------------- #
# Install Important Packages #
# -------------------------- #
sudo pacman -S --noconfirm \
	firewalld \
	networkmanager \
	wpa_supplicant \
	dhclient \
	iw wireless_tools \
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
	xdg-utils

# Configure firewall
sudo tee /etc/NetworkManager/conf.d/00-local.conf <<EOF >/dev/null
[main]
firewall-backend=none
EOF

# Here are some recommendations To improve and enhance Wi-Fi and internet speed:
# This disables Wi-Fi power-saving mode, which can help improve performance.
sudo tee /etc/NetworkManager/NetworkManager.conf <<EOF >>/dev/null
[connection]
wifi.powersave = 2
EOF

# Disable IPv6
sudo tee /etc/sysctl.d/ipv6.conf <<EOF >/dev/null
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.eth0.disable_ipv6 = 1
EOF

### Check Existing Policies
sudo firewall-cmd --permanent --get-policies

### Remove Existing Policies
sudo firewall-cmd --permanent --delete-policy=egress-shared
sudo firewall-cmd --permanent --delete-policy=ingress-shared

### Add New Policies
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
# Set up NAT using iptables to allow the network traffic to be forwarded:
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan0 -o eno1 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i eno1 -o wlan0 -j ACCEPT
# Save iptables Rules
# To ensure the iptables rules persist after a reboot, save them using `iptables-save`:
sudo iptables-save >/etc/iptables/iptables.rules

# Enable IP Forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# --------------- #
# Enable Services #
# --------------- #
sudo -i
# check the status of the service (running and enabled)
systemctl status iptables
# if the service is not running, start it
systemctl start iptables
# if the service has exited, restart it(check for error if any)
systemctl restart iptables
# if the service is not enabled, enable it
systemctl enable iptables

systemctl status firewalld
systemctl start firewalld
systemctl restart firewalld
systemctl enable firewalld

systemctl status dnsmasq
systemctl start dnsmasq
systemctl restart dnsmasq
systemctl enable dnsmasq

systemctl status NetworkManager
systemctl start NetworkManager
systemctl restart NetworkManager
systemctl enable NetworkManager

systemctl status systemd-resolved
systemctl start systemd-resolved
systemctl restart systemd-resolved
systemctl enable systemd-resolved

exit
# --------------------------------
