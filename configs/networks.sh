#!/bin/bash

#############################
# Install firewalld
#############################
sudo pacman -S firewalld networkmanager wpa_supplicant dhclient iw wireless_tools dialog iptables dnsmasq hostapd nm-connection-editor connman dhcpcd network-manager-applet
sudo systemctl start firewalld
sudo systemctl enable firewalld

sudo tee /etc/NetworkManager/conf.d/00-local.conf << EOF > /dev/null
[main]
firewall-backend=none
EOF
sudo systemctl restart NetworkManager.service
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

sudo sysctl -w net.ipv4.ip_forward=1


sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager


#EDIT: So I tried disabling IPv6 by creating the file /etc/sysctl.d/ipv6.conf containing:
 # Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.eth0.disable_ipv6 = 1
