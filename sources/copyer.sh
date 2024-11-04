#!/usr/bin/env bash
copy_files() {
	echo "()=> Copying files"
	mkdir -p ~/.config
	
  # "$HOME"/dotfiles/setup/copy.sh
  echo ":: gtk..."

  mv "$HOME"/.config/gtk-3.0 --backup "$HOME"/.config/gtk-3.0-bk
  mv "$HOME"/.config/gtk-4.0 --backup "$HOME"/.config/gtk-4.0-bk
  
  cp -r -f "$HOME"/dotfiles/setup/gtk-3.0 "$HOME"/.config/
  cp -r -f "$HOME"/dotfiles/setup/gtk-4.0 "$HOME"/.config/
  
  echo ":: wl-gammarelay..."
  mkdir -p "$HOME"/.config/systemd/user/
  cp "$HOME"/dotfiles/setup/wl-gammarelay.service "$HOME"/.config/systemd/user/
  systemctl --user daemon-reload
  systemctl --user enable --now wl-gammarelay.service

  echo ":: Product Sans font"
  sudo cp -r "$HOME"/dotfiles/setup/google-sans /usr/share/fonts
  sudo fc-cache -f -v

  echo ":: Done!"


	if [ -d "$HOME/wallpaper" ]; then
		echo ":: Error: directory wallpaper already exists in home"
	else
		cp -r "$HOME"/dotfiles/wallpapers "$HOME"/wallpaper
	fi
}
create_links() {
	echo ":: Creating links"
	ln -f /data/current/Linuxuration/.config/electron-flags.conf ~/.config/electron-flags.conf
	ln -s /data/current/Linuxuration/.config/ags ~/.config/ags
	ln -s /data/current/Linuxuration/.config/code-flags.conf ~/.config/code-flags.conf
	ln -s /data/current/Linuxuration/.config/gtk-2.0 ~/.config/gtk-2.0
	ln -s /data/current/Linuxuration/.config/gtk-3.0 ~/.config/gtk-3.0
	ln -s /data/current/Linuxuration/.config/gtk-4.0 ~/.config/gtk-4.0
	ln -s /data/current/Linuxuration/.config/hypr ~/.config/hypr
	ln -s /data/current/Linuxuration/.config/kitty ~/.config/kitty
	ln -s /data/current/Linuxuration/.config/msedge-flags.conf ~/.config/msedge-flags.conf
	ln -s /data/current/Linuxuration/.config/psd ~/.config/psd
	ln -s /data/current/Linuxuration/.config/qt5ct ~/.config/qt5ct
	ln -s /data/current/Linuxuration/.config/qt6ct ~/.config/qt6ct
	ln -s /data/current/Linuxuration/.config/scripts ~/.config/scripts
	ln -s /data/current/Linuxuration/.config/swappy ~/.config/swappy
	ln -s /data/current/Linuxuration/home/.zshrc ~/.zshrc
	ln -s /data/current/Linuxuration/home/wallpapers ~/wallpapers
  ls -s /data/current/Linuxuration/home/mumble-dark.qbtheme ~/mumble-dark.qbtheme
}
