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
	ln -f "$HOME"/dotfiles/electron-flags.conf "$HOME"/.config/electron-flags.conf
	ln -s "$HOME"/dotfiles/ags "$HOME"/.config/ags
	ln -s "$HOME"/dotfiles/alacritty "$HOME"/.config/alacritty
	ln -s "$HOME"/dotfiles/hypr "$HOME"/.config/hypr
	ln -s "$HOME"/dotfiles/swappy "$HOME"/.config/swappy
}