#!/bin/bash
# --------------------------
# Gnome Extensions
# --------------------------

# sudo pacman -S --noconfirm gnome-shell gnome-shell-extensions gnome-shell-extension-prefs

# Function to install the latest gnome-shell-extension-installer script
install_extension_installer() {
    echo "Downloading the latest gnome-shell-extension-installer..."
    mkdir -p ~/.local/bin
    echo 'export PATH=$PATH:~/.local/bin' >>~/.bashrc
    source ~/.bashrc
    wget -O ~/.local/bin/gnome-shell-extension-installer https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer
    chmod +x ~/.local/bin/gnome-shell-extension-installer
}

# Function to install an extension by ID
install_gnome_extension() {
    local extension_id=$1
    echo "Installing GNOME extension with ID: $extension_id..."
    gnome-shell-extension-installer $extension_id
}

# Install the gnome-shell-extension-installer if not present
if [ ! -f ~/.local/bin/gnome-shell-extension-installer ]; then
    install_extension_installer
else
    echo "gnome-shell-extension-installer is already installed."
fi

# Install Dash to Dock extension (ID 307)
install_gnome_extension 307

# Install User Themes extension (ID 19)
install_gnome_extension 19

# Install Net speed Simplified extension (ID 3724)
install_gnome_extension 3724

# Install Control Blur Effect On Lockscreen extension (ID 2935)
install_gnome_extension 2935

# Install AppIndicator and KStatusNotifierItem Support extension (ID 615)
install_gnome_extension 615

# Install Pomodoro extension (ID 53)
install_gnome_extension 53

# Install dash2dock-lite extension (ID 4994)
install_gnome_extension 4994

# Install blur-my-shell extension (ID 3193)
install_gnome_extension 3193

# Enable the extension (UUID dash-to-dock@micxgx.gmail.com)
gnome-extensions enable dash-to-dock@micxgx.gmail.com

echo "Installation and enabling of GNOME extension completed."

#########################
# install gnome-pomodoro
#########################
yay -S gnome-pomodoro
