#!/bin/bash
# ---------------------------------------------- #
# Here some fixies for Network & WIFI & Internet #
# ---------------------------------------------- #
# Features:
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
	firewalld networkmanager \
	wpa_supplicant dhclient \
	iw wireless_tools \
	dialog iptables dnsmasq \
	hostapd nm-connection-editor \
	connman dhcpcd network-manager-applet netctl

# Configure firewall
sudo tee /etc/NetworkManager/conf.d/00-local.conf <<EOF >/dev/null
[main]
firewall-backend=none
EOF
sudo systemctl restart NetworkManager.service

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
sudo systemctl enable iptables

# Enable IP Forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# ----------------------------------------
sudo -i
# check the status of the service (running and enabled)
systemctl status firewalld
# if the service is not running, start it
systemctl start firewalld
# if the service has exited, restart it(check for error if any)
systemctl restart firewalld
# if the service is not enabled, enable it
systemctl enable firewalld

# check the status of the service (running and enabled)
systemctl status dnsmasq
# if the service is not running, start it
systemctl start dnsmasq
# if the service has exited, restart it(check for error if any)
systemctl restart dnsmasq
# if the service is not enabled, enable it
systemctl enable dnsmasq

# check the status of the service (running and enabled)
systemctl status NetworkManager
# if the service is not running, start it
systemctl start NetworkManager
# if the service has exited, restart it(check for error if any)
systemctl restart NetworkManager
# if the service is not enabled, enable it
systemctl enable NetworkManager

# check the status of the service (running and enabled)
systemctl status systemd-resolved
# if the service is not running, start it
systemctl start systemd-resolved
# if the service has exited, restart it(check for error if any)
systemctl restart systemd-resolved
# if the service is not enabled, enable it
systemctl enable systemd-resolved

exit
# --------------------------------

# Here are some recommendations To improve and enhance Wi-Fi and internet speed:
# This disables Wi-Fi power-saving mode, which can help improve performance.
sudo tee /etc/NetworkManager/NetworkManager.conf <<EOF >>/dev/null
[connection]
wifi.powersave = 2
EOF

# Disable IPv6
# sudo tee /etc/sysctl.d/ipv6.conf << EOF > /dev/null
# net.ipv6.conf.all.disable_ipv6 = 1
# net.ipv6.conf.eth0.disable_ipv6 = 1
# EOF
