#!/bin/bash
# ------------------------------------------- #
# Common Packages for Poth Hyprland and Gnome #
# sudo nano /etc/pacman.conf
# sudo nano /etc/makepkg.conf
# ------------------------------------------- #
sudo pacman -S --needed --noconfirm \
	gedit \
	vlc \
	ffmpeg \
	gstreamer \
	gst-plugins-good \
	gst-plugins-ugly \
	libdvdcss \
	gnome \
	gnome-shell-extensions \
	wayland \
	xorg-server \
	xf86-input-libinput \
	mesa \
	xf86-video-amdgpu \
	linux-headers \
	mesa \
	lib32-mesa \
	qt6-wayland \
	python-pip \
	inkscape \
	ttf-liberation \
	vlc \
	gnome-tweaks \
	base-devel git \
	ffmpegthumbs \
	boost \
	gstreamer \
	gstreamer0.10 \
	gstreamer0.10-bad \
	gstreamer0.10-bad-plugins \
	gstreamer0.10-base \
	gstreamer0.10-base-plugins \
	gstreamer0.10-good \
	gstreamer0.10-good-plugins \
	gstreamer0.10-ugly \
	gstreamer0.10-ugly-plugins \
	gstreamer0.10-openh264 \
	gstreamer0.10-libav \
	gstreamer \
	gstreamer1-plugins-base \
	gstreamer1-plugins-good \
	gstreamer1-plugin-openh264 \
	gstreamer1-libav \
	gnome-tweaks \
	gnome-extensions-app \
	grub-customizer \
	networkmanager-tui \
	aircrack-ng \
	clang \
	dbus \
	gperf \
	gtk3 \
	libnotify \
	gnome-keyring \
	libcap \
	cups \
	libxtst \
	alsa-lib \
	libxrandr \
	nss \
	python-dbusmock \
	libpcap \
	gcc \
	hcxtools \
	libxss \
	rustup \
	corectrl \
	execstack \
	devscripts \
	ncurses \
	ncurses5-compat-libs \
	pnpm \
	yarn \
	bun \
	libsoup \
	javascriptcoregtk \
	webkit2gtk \
	grpc \
	firewalld \
	qt5-webengine \
	libglvnd \
	atk at-spi2-core at-spi2-atk \
	qt5-base qt5-webengine \
	mesa xf86-video-amdgpu

# Install packages from AUR using yay
yay -S --needed --noconfirm \
	gstreamer1-plugins-bad \
	gstreamer1-plugins-good \
	gstreamer1-plugins-base \
	gstreamer1-plugin-openh264 \
	gstreamer1-libav \
	gstreamer1-plugins-bad-free-devel \
	networkmanager-tui \
	gnome-tweaks \
	gnome-extensions-app \
	execstack-0.5.0-27.fc40.x86_64 \
	devscripts \
	ncurses \
	ncurses-compat-libs \
	pnpm \
	yarn \
	bun \
	libsoup \
	javascriptcoregtk \
	webkit2gtk \
	grpc \
	firewalld \
	nwg-shell \
	lxappearance \
	gtk-engine-murrine

# packages

# Set up QEMU
yay -S --noconfirm qemu
sudo ln -s /usr/bin/qemu-system-x86_64

# Set up Rust
rustup toolchain install stable
rustup default stable

# Set up Python
pip install -r requirements.txt

# Set up NodeJS
yay -S --noconfirm nodejs
npm install -g yarn
yarn

# Set up C
yay -S --noconfirm clang
yay -S --noconfirm libc++

# Set up C++
yay -S --noconfirm libstdc++

# Set up C#
yay -S --noconfirm dotnet-sdk

# Set up Go
yay -S --noconfirm go

# Set up Docker
yay -S --noconfirm docker
sudo systemctl start docker
sudo systemctl enable docker

# Set up Docker Compose
yay -S --noconfirm docker-compose
sudo ln -s /usr/bin/docker-compose /usr/local/bin/docker-compose

# Set up WireGuard
yay -S --noconfirm wireguard-tools

# Set up SSH
yay -S --noconfirm openssh
sudo systemctl enable sshd

# Set up Git
yay -S --noconfirm git

# Set up Git LFS
yay -S --noconfirm git-lfs
git lfs install

# Set up Tmux
yay -S --noconfirm tmux

# Set up Vim
yay -S --noconfirm vim

# Set up ZSH
yay -S --noconfirm zsh

# Set up ZSH Plugins
yay -S --noconfirm zsh-syntax-highlighting
yay -S --noconfirm zsh-autosuggestions
yay -S --noconfirm zsh-completions

# Set up Oh My ZSH
yay -S --noconfirm oh-my-zsh

# Set up NPM
yay -S --noconfirm npm

# Set up Python
yay -S --noconfirm python

# Set up NodeJS
yay -S --noconfirm nodejs
