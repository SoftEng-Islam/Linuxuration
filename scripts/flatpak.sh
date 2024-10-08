#!/bin/bash
# ------------------------------------------- #
# Install Flatpak Applications and Extensions #
# ------------------------------------------- #
i_flatpak() {
	sudo pacman -S flatpak --noconfirm
	# Add the Flathub remote
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	# Reboot your system (optional) Rebooting ensures that everything is properly set up, but its not strictly necessary.
	# sudo reboot
	# Increase the timeout settings for Flatpak
	FLATPAK_CONF="/etc/flatpak/flatpak.conf"
	echo "[Network]" | sudo tee -a $FLATPAK_CONF >/dev/null
	echo "RequestTimeout=1000" | sudo tee -a $FLATPAK_CONF >/dev/null
	echo "Timeout settings updated in $FLATPAK_CONF"
	# List of Flatpak applications to install
	Applications=(
		# ------------------------------------------- // Audio/Video
		"com.github.rafostar.Clapper"      # Clapper
		"com.github.unrud.VideoDownloader" # Video Downloader
		"com.obsproject.Studio"            # OBS Studio
		"net.base_art.Glide"               # Glide
		"org.audacityteam.Audacity"        # Audacity
		"org.kde.kdenlive"                 # Kdenlive
		"org.gnome.eog"                    # Image Viewer

		# ------------------------------------------- // System
		"com.github.tchx84.Flatseal"       # Flatseal
		"com.mattjakeman.ExtensionManager" # Extension Manager
		"io.github.flattool.Warehouse"     # Warehouse
		"io.gitlab.adhami3310.Impression"  # Impression
		"io.missioncenter.MissionCenter"   # Mission Center
		"net.nokyan.Resources"             # Resources
		"org.filezillaproject.Filezilla"   # Filezilla
		"org.gnome.Boxes"                  # Boxes
		"org.gnome.Calculator"             # Calculator
		"org.gnome.Connections"            # Connections
		"org.gnome.Loupe"                  # Loupe
		"org.gnome.Photos"                 # Photos
		"fr.romainvigier.MetadataCleaner"  # Metadata Cleaner

		# ------------------------------------------- // Browser
		"com.google.Chrome"   # Google Chrome
		"com.microsoft.Edge"  # Microsoft Edge
		"org.mozilla.firefox" # Firefox

		# ------------------------------------------- // Social
		"com.discordapp.Discord" # Discord
		"org.telegram.desktop"   # Telegram

		# ------------------------------------------- // Productivity
		"com.jgraph.drawio.desktop"   # draw.io
		"md.obsidian.Obsidian"        # Obsidian
		"org.libreoffice.LibreOffice" # LibreOffice
		"org.mozilla.Thunderbird"     # Thunderbird

		# ------------------------------------------- // Image/Graphics
		"com.icons8.Lunacy"                  # Lunacy
		"io.gitlab.theevilskeleton.Upscaler" # Image Upscaler
		"org.blender.Blender"                # Blender
		"org.gimp.GIMP"                      # GIMP
		"org.inkscape.Inkscape"              # Inkscape
		"org.kde.krita"                      # Krita
		"org.freecadweb.FreeCAD"             # FreeCAD

		# ------------------------------------------- // Photography
		# (You can add more photography-related apps here as needed)

		# ------------------------------------------- // Gaming
		"org.gnome.Chess" # Chess

		# ------------------------------------------- // Development
		"com.getpostman.Postman"      # Postman
		"com.slack.Slack"             # Slack
		"com.visualstudio.code"       # Visual Studio Code
		"io.beekeeperstudio.Studio"   # Beekeeper Studio
		"io.dbeaver.DBeaverCommunity" # DBeaver Community
		"rest.insomnia.Insomnia"      # Insomnia
		"com.github.zadam.trilium"    # Trilium
		"org.qbittorrent.qBittorrent" # qBittorrent
	)
	# Function to install Flatpak applications
	installFlatpakApps() {
		for app in "${Applications[@]}"; do
			echo "Installing $app..."
			flatpak install flathub "$app" -y
			echo "---------------------------------------------"
		done
	}
	# Main execution
	installFlatpakApps
	echo "All Flatpak applications installed successfully."
}