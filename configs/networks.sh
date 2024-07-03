#!/bin/bash

#############################
# Install firewalld
#############################
sudo pacman -S firewalld networkmanager wpa_supplicant dhclient iw wireless_tools dialog iptables dnsmasq hostapd nm-connection-editor connman dhcpcd network-manager-applet netctl
sudo systemctl start firewalld
sudo systemctl enable firewalld

sudo tee /etc/NetworkManager/conf.d/00-local.conf << EOF > /dev/null
[main]
firewall-backend=none
EOF
sudo systemctl restart NetworkManager.service


sudo firewall-cmd --permanent --delete-policy=egress-shared
sudo firewall-cmd --permanent --delete-policy=ingress-shared

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





# check the status of the service (running and enabled)
sudo systemctl status firewalld

# if the service is not running, start it
sudo systemctl start firewalld

# if the service has exited, restart it(check for error if any)
sudo systemctl restart firewalld

# if the service is not enabled, enable it
sudo systemctl enable firewalld


# check the status of the service (running and enabled)
sudo systemctl status dnsmasq

# if the service is not running, start it
sudo systemctl start dnsmasq

# if the service has exited, restart it(check for error if any)
sudo systemctl restart dnsmasq

# if the service is not enabled, enable it
sudo systemctl enable dnsmasq


# check the status of the service (running and enabled)
sudo systemctl status NetworkManager

# if the service is not running, start it
sudo systemctl start NetworkManager

# if the service has exited, restart it(check for error if any)
sudo systemctl restart NetworkManager

# if the service is not enabled, enable it
sudo systemctl enable NetworkManager



# check the status of the service (running and enabled)
sudo systemctl status systemd-resolved

# if the service is not running, start it
sudo systemctl start systemd-resolved

# if the service has exited, restart it(check for error if any)
sudo systemctl restart systemd-resolved

# if the service is not enabled, enable it
sudo systemctl enable systemd-resolved






# Disable IPv6
# sudo tee /etc/sysctl.d/ipv6.conf << EOF > /dev/null
# net.ipv6.conf.all.disable_ipv6 = 1
# net.ipv6.conf.eth0.disable_ipv6 = 1
# EOF
