echo -e <<EOF
Welcome $(whoami)
EOF


# Write some information about Your PC
lsmod | grep amdgpu
echo $XDG_SESSION_TYPE
lspci -k | grep -EA3 'VGA|3D|Display'
lspci -k | grep -A 2 -E "(VGA|3D)"


#########################
# Update system Packages
#########################
echo 'Update The Packages'
sudo -i
pacman -Syu --noconfirm && pacman -Sc --noconfirm


# To Support Microsoft Partition FileSystem Format 'NTFS'
echo 'Install ntfs-3g to Support MS partition file system'
pacman -Sy ntfs-3g
modprobe fuse





####################################################
# Make stars appear when type sudo password
#echo 'make stars appear when type sudo password'
#echo '' >>
####################################################






##################################
# **Install `dnsmasq`**
##################################
`sudo pacman -S dnsmasq`
sudo systemctl enable dnsmasq.service
sudo systemctl start dnsmasq.service

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




pacman -S flatpak --noconfirm
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo 'Disable Gnome Check-alive'
gsettings set org.gnome.mutter check-alive-timeout 0


# increase the timeout settings for Flatpak
FLATPAK_CONF="/etc/flatpak/flatpak.conf"
echo "[Network]" >> $FLATPAK_CONF
# Increase timeout settings (adjust as needed)
echo "RequestTimeout=800" >> $FLATPAK_CONF
echo "Timeout settings updated in $FLATPAK_CONF"



sudo usermod -aG video,input @user

sudo pacman -S gedit vlc ffmpeg gstreamer gst-plugins-good gst-plugins-ugly libdvdcss gnome gnome-shell-extensions wayland xorg-server xf86-input-libinput
sudo pacman -S mesa xf86-video-amdgpu linux-headers mesa lib32-mesa
sudo pacman -S alacritty



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







###############################
# Install Packages with pacman
###############################
echo 'Install Needed Packages'
pacman -S --needed --noconfirm base-devel git

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
	"com.visualstudio.code"
	"org.mozilla.firefox"
	"net.nokyan.Resources"
	"com.microsoft.Edge"
	"com.google.Chrome"
	"com.mattjakeman.ExtensionManager"
	"org.qbittorrent.qBittorrent"
	"com.protonvpn.www"
	"com.github.zadam.trilium"
	org.gnome.Boxes
	com.getpostman.Postman
	io.dbeaver.DBeaverCommunity
	rest.insomnia.Insomnia
	com.discordapp.Discord
	org.telegram.desktop
	org.libreoffice.LibreOffice
	org.mozilla.Thunderbird

	# Add more applications as needed
)
# Function to install Flatpak applications
install_flatpak_apps() { 
	for app in "${APPS[@]}"; do
		echo "Installing $app..."
		flatpak install flathub $app -y
		echo "---------------------------------------------" 
	done 
	}
# Main execution
install_flatpak_apps
echo "All Flatpak applications installed successfully."



# Add Microsoft repository for VS Code
echo "Adding Microsoft repository for VS Code..."
echo "[code]" | sudo tee /etc/pacman.d/microsoft.repo > /dev/null echo "Server = https://packages.microsoft.com/yumrepos/vscode" | sudo tee -a /etc/pacman.d/microsoft.repo > /dev/null
sudo pacman -Sy --noconfirm

# Install VS Code echo "Installing Visual Studio Code..."
sudo pacman -S --noconfirm code

echo "Visual Studio Code installation completed."




echo 'Install Visual Studio Code (VS Code)'
cat <<EOF > /etc/pacman.d/microsoft.repo
[code]
Server = https://packages.microsoft.com/yumrepos/vscode
EOF

echo 'Include = /etc/pacman.d/microsoft.repo' >> /etc/pacman.conf

sudo pacman -Sy
sudo pacman -S code


######################
# git improvement
######################
git config advice.addIgnoredFile false