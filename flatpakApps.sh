# List of Flatpak applications to install (replace with your desired apps)
APPS=(
	"com.visualstudio.code"
	"org.gnome.Calculator"
	"org.mozilla.firefox"
	"net.nokyan.Resources"
	"com.microsoft.Edge"
	"com.google.Chrome"
	"com.mattjakeman.ExtensionManager"
	"org.qbittorrent.qBittorrent"
	"com.protonvpn.www"
	"com.github.zadam.trilium"
	# Add more applications as needed
)
# Function to install Flatpak applications
installFlatpakApps() {
	for app in "${APPS[@]}";
		echo "Installing $app..."
		flatpak install flathub $app -y
		echo "---------------------------------------------" 
	done 
}
# Main execution
installFlatpakApps
echo "All Flatpak applications installed successfully."
