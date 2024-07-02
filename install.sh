#!/bin/bash

# The Welcome Section
echo -e "$(cat <<EOF

Welcome \e[1;32m$(whoami)\e[0m
Today's date is: \e[93m$(date)\e[0m \n
feel free to message me on Twitter: https://x.com/SoftEng_Islam


EOF
)"



#########################
# Update the Packages
#########################
echo 'update the packages'
sudo -i
pacman -Syu --noconfirm && pacman -Sc --noconfirm

###############################
# Install Packages with pacman
###############################
echo 'Install Needed Packages'
pacman -S --needed --noconfirm base-devel git
sudo pacman -S --noconfirm gedit vlc ffmpeg gstreamer gst-plugins-good gst-plugins-ugly libdvdcss gnome gnome-shell-extensions wayland xorg-server xf86-input-libinput mesa xf86-video-amdgpu linux-headers mesa lib32-mesa
yay -S gtk-engine-murrine

# Microsoft Partition FileSystem Format 'NTFS'
echo 'Install ntfs-3g to Support MS partition file system'
pacman -Sy --noconfirm ntfs-3g
modprobe fuse

# Install ZSH & oh-my-zsh
sudo pacman -S --noconfirm zsh fzf
chsh -s /bin/zsh


# Kitty terminal emulator
echo 'Install Kitty terminal emulator'
sudo pacman -S --noconfirm kitty
echo 'Set Kitty as the Default Terminal:'
export TERMINAL=kitty
# Kitty's configuration file can be found at ~/.config/kitty/kitty.conf.
# You can customize Kitty's appearance and behavior by editing this file.





# ######################
# install-OneUI
########################

#####################
# install-bibata
#####################

#########################
# install gnome-pomodoro
#########################
yay -S gnome-pomodoro


#####################################
# Install Fonts
#####################################
echo 'Use yay to install JetBrains Mono:'
# To Verify the installation:
# ls /usr/share/fonts/TTF | grep JetBrains
yay -S ttf-jetbrains-mono
# Update the font cache:
echo 'Update the font Cache'
sudo fc-cache -fv



echo 'Disable Gnome Check-alive'
gsettings set org.gnome.mutter check-alive-timeout 0




pacman -S flatpak --noconfirm
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# increase the timeout settings for Flatpak
FLATPAK_CONF="/etc/flatpak/flatpak.conf"
echo "[Network]" >> $FLATPAK_CONF
# Increase timeout settings (adjust as needed)
echo "RequestTimeout=800" >> $FLATPAK_CONF
echo "Timeout settings updated in $FLATPAK_CONF"



#######################
# overclocing
#######################
yay -S corectrl



############
# plymouth
############
sudo pacman -S plymouth
sudo plymouth-set-default-theme -R arch-logo
sudo mkinitcpio -p linux
sudo systemctl daemon-reload
systemctl status plymouth.service
ls /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R details





##########################
# Install ZSH & oh_my_zsh
##########################





################################
# Install Some Gnome Extensions
################################









echo 'Install yay'
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo 'Install debtap by yay'
yay -S debtap

echo 'Initialize `debtap` (only needed the first time)'
debtap -u



##########################
# Install Apps
# `flatpak install -y flathub com.visualstudio.code org.mozilla.firefox`
##########################
echo 'Installing Resources App'
flatpak install flathub com.visualstudio.code  org.mozilla.firefox
net.nokyan.Resources com.microsoft.Edge com.google.Chrome com.mattjakeman.ExtensionManager org.qbittorrent.qBittorrent com.protonvpn.www com.github.zadam.trilium



# List of Flatpak applications to install (replace with your desired apps)
APPS=(
	# "com.visualstudio.code"
	"org.mozilla.firefox"
	"com.microsoft.Edge"
	"com.google.Chrome"
	"net.nokyan.Resources"
	"com.mattjakeman.ExtensionManager"
	"org.qbittorrent.qBittorrent"
	"com.github.zadam.trilium"
	"org.gnome.Boxes"
	"com.getpostman.Postman"
	"io.dbeaver.DBeaverCommunity"
	"rest.insomnia.Insomnia"
	"com.discordapp.Discord"
	"org.telegram.desktop"
	"org.libreoffice.LibreOffice"
	"org.mozilla.Thunderbird"
	"md.obsidian.Obsidian"
	"org.gimp.GIMP"
	"org.kde.krita"
	"org.kde.kdenlive"
	"org.blender.Blender"
	"com.obsproject.Studio"
	"org.gnome.Chess"
	# Add more applications as needed
)
# Function to install Flatpak applications
install_flatpak_apps() {
	for app in "${APPS[@]}"; do
		echo "Installing $app..."
		flatpak install flathub $app -y
		echo "---------------------------------------------"
	done
	}
# Main execution
install_flatpak_apps
echo "All Flatpak applications installed successfully."
