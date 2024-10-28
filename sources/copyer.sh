#!/usr/bin/env bash
copy_files() {
	echo ":: Copying files"
	mkdir -p "$HOME"/.config
	"$HOME"/dotfiles/setup/copy.sh
	if [ -d "$HOME/wallpaper" ]; then
		echo ":: Error: directory wallpaper already exists in home"
	else
		cp -r "$HOME"/dotfiles/wallpapers "$HOME"/wallpaper
	fi
}
create_links() {
	echo ":: Creating links"
	# ln -f "$HOME"/dotfiles/electron-flags.conf "$HOME"/.config/electron-flags.conf
	# ln -s "$HOME"/dotfiles/ags "$HOME"/.config/ags
	# ln -s "$HOME"/dotfiles/alacritty "$HOME"/.config/alacritty
	# ln -s "$HOME"/dotfiles/hypr "$HOME"/.config/hypr
	# ln -s "$HOME"/dotfiles/swappy "$HOME"/.config/swappy

	ln -s /data/current/Linuxuration/.config/ags ~/.config/ags
	ln -s /data/current/Linuxuration/.config/hypr ~/.config/hypr
	ln -s /data/current/Linuxuration/.config/gtk-3.0 ~/.config/gtk-3.0
	ln -s /data/current/Linuxuration/.config/gtk-4.0 ~/.config/gtk-4.0
	ln -s /data/current/Linuxuration/.config/qt5ct ~/.config/qt5ct
	ln -s /data/current/Linuxuration/.config/qt6ct ~/.config/qt6ct
	ln -s /data/current/Linuxuration/.config/psd ~/.config/psd
	ln -s /data/current/Linuxuration/.config/electron-flags.conf ~/.config/electron-flags.conf
	ln -s /data/current/Linuxuration/.config/msedge-flags.conf ~/.config/msedge-flags.conf
	ln -s /data/current/Linuxuration/home/.zshrc ~/.zshrc
	ln -s /data/current/Linuxuration/home/softeng.zsh-theme ~/softeng.zsh-theme
	ln -s /data/current/Linuxuration/home/wallpapers ~/wallpapers
	ln -s /data/current/Linuxuration/.config/scripts ~/.config/scripts
}
