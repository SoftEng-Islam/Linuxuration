#!/bin/bash
# ------------------------------------ #
# Script to install suggested packages #
# ------------------------------------ #

# Create log file
touch ./packages.log
# Function to log messages
log_message() {
  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "[$timestamp] $1" >>./packages.log
}

# Empty arrays to store packages
pacman_to_install=()
yay_to_install=()

# pacman_not_exist=()
# yay_not_exist=()

# Create an array of packages
allPackages=(
  # Text Editor
  gedit
  # Media Tools
  vlc              # Multimedia player
  ffmpeg           # Multimedia framework
  gstreamer        # Media framework
  gst-plugins-good # Good set of GStreamer plugins
  gst-plugins-ugly # Ugly set of GStreamer plugins
  libdvdcss        # Library for accessing encrypted DVDs
  # GNOME Desktop Environment
  gnome                  # GNOME desktop environment
  gnome-shell-extensions # Extensions for GNOME Shell
  gnome-tweaks           # GNOME tweaking tool
  gnome-extensions-app   # Manage GNOME Shell extensions
  gnome-keyring          # GNOME keyring management
  gnome-control-center   # GNOME Control Center
  # Display Server and Graphics
  wayland             # Wayland display server protocol
  xorg-server         # X.Org server
  xf86-input-libinput # Input driver for X.Org
  mesa                # Mesa 3D graphics library
  xf86-video-amdgpu   # AMD GPU driver for X.Org
  qt6-wayland         # Qt6 Wayland platform plugin
  gtk3                # GTK3 library
  libnotify           # Notification library
  libcap              # POSIX capabilities library
  libxtst             # X11 Test extension library
  libxrandr           # X11 RandR extension library
  # Hyprland and Wayland-Related Packages
  hyprland                    # Hyprland window manager
  waybar                      # Highly customizable status bar for Wayland
  swaylock-effects            # Screen locker for Wayland with fancy effects
  wofi                        # Application launcher for Wayland
  xdg-desktop-portal-hyprland # Desktop portal for Hyprland
  # Terminal Enhancements
  alacritty     # Terminal emulator
  kitty         # Terminal emulator
  tmux          # Terminal multiplexer
  powerlevel10k # Zsh theme
  lsd           # Modern replacement for 'ls'
  fzf           # Command-line fuzzy finder
  bat           # Cat clone with syntax highlighting
  exa           # Modern replacement for 'ls'
  fd            # Simple, fast alternative to 'find'
  ripgrep       # Line-oriented search tool
  # Development Tools
  neovim                          # Text editor
  code                            # Visual Studio Code
  intellij-idea-community-edition # IntelliJ IDEA Community Edition
  clang                           # C language family frontend
  gdb                             # GNU Debugger
  cmake                           # Cross-platform build system
  ninja                           # Build system
  docker                          # Container platform
  podman                          # Manage pods, containers, and images
  git-lfs                         # Git extension for versioning large files
  kubectl                         # Kubernetes command-line tool
  gradle                          # Build automation tool
  python-pip                      # Python package installer
  rustup                          # Rust toolchain installer
  gcc                             # GNU Compiler Collection
  corectrl                        # Graphical system management tool
  devscripts                      # Scripts for Debian development
  ncurses                         # Terminal handling library
  qt5-webengine                   # Web engine for Qt5
  pkg-config                      # Manage compile and link flags for libraries
  boost                           # C++ library
  gperf                           # Perfect hash function generator
  gtkmm3                          # C++ bindings for GTK3
  base-devel                      # Development tools (make, gcc, etc.)
  ttf-liberation                  # Liberation fonts

  # Performance and Optimization
  earlyoom       # Out-of-memory management
  thermald       # Thermal management
  tlp            # Power management
  cpupower       # CPU power management
  iotop          # Display I/O usage
  htop           # Interactive process viewer
  btop           # Resource monitor
  preload        # Adaptive readahead daemon
  zram-generator # Compressed RAM with ZRAM

  # General Utilities
  syncthing # Continuous file synchronization
  ranger    # Terminal file manager
  ncdu      # Disk usage analyzer
  bleachbit # System cleaner
  gparted dosfstools jfsutils f2fs-tools btrfs-progs exfatprogs ntfs-3g
  udftools xfsprogs nilfs-utils polkit gpart mtools xorg-xhost # Partition editor

  timeshift   # System restore tool
  resolvconf  # DNS resolution manager
  gnome-disks # Manage disk drives and media
  # Additional Utilities
  grub-customizer         # GUI tool to configure GRUB2
  networkmanager-tui      # Text user interface for NetworkManager
  aircrack-ng             # Wireless network security tools
  hcxtools                # WPA/WPA2/PMKID penetration testing toolkit
  dbus                    # Message bus system
  qt5-base                # Qt5 base library
  libglvnd                # Vendor-neutral OpenGL dispatch library
  atk                     # Accessibility Toolkit
  at-spi2-core            # Assistive Technology Service Provider Interface
  gvfs-mtp                # MTP filesystem support for GVFS
  android-tools           # Android platform tools
  wireplumber             # Audio and video routing system
  pavucontrol             # PulseAudio volume control
  playerctl               # Media player controller
  webp-pixbuf-loader      # WebP image loader for GdkPixbuf
  gtk-layer-shell         # Library to create Wayland popups
  yad                     # Yet Another Dialog
  ydotool                 # Generic command-line automation tool
  polkit-gnome            # GNOME authentication agent
  gnome-bluetooth-3.0     # GNOME Bluetooth tools
  brightnessctl           # Control device brightness
  ddcutil                 # Control monitor settings
  dart-sass               # Dart Sass compiler
  python-pywayland        # Python bindings for the Wayland protocol
  python-psutil           # Cross-platform process and system utilities
  hyprpicker-git          # Color picker for Hyprland
  anyrun-git              # Run anything from your terminal
  adw-gtk3-git            # Adwaita theme for GTK3
  qt5ct                   # Qt5 Configuration Tool
  fontconfig              # Font configuration and customization library
  ttf-jetbrains-mono-nerd # Nerd Font patched JetBrains Mono
  fish                    # Friendly interactive shell
  foot                    # Wayland terminal emulator
  starship                # Cross-shell prompt for astronauts
  swappy                  # Wayland screenshot editor
  rustup                  # Rust toolchain installer
  yad                     # Yet Another Dialog
  mpv                     # Media player
  xdg-desktop-portal      # Desktop integration portal
  # Audio
  strawberry
  lollypop
  audacious
  elisa
  kwave
  audacity
  ardour
  lmms
  mixxx
  musescore
  rosegarden
  bitwig-studio

  # Browsers
  cachy-browser
  librewolf-bin
  firefox
  firefox-esr-bin
  chromium
  ungoogled-chromium
  vivaldi
  vivaldi-ffmpeg-codecs
  torbrowser-launcher
  brave-bin
  falkon
  qutebrowser
  python-adblock

  # Communication
  telegram-desktop
  discord
  neochat
  fractal
  element-desktop
  wire-desktop
  signal-desktop
  zoom
  teams
  slack-desktop
  mumble

  # Development
  vim
  code
  atom
  emacs
  qtcreator
  gnome-builder
  kdevelop
  netbeans
  intellij-idea-community-edition
  pycharm-community-edition
  gitkraken
  cockpit
  cockpit-machines
  ansible
  docker
  docker-compose
  podman-docker
  podman-compose
  crun
  salt
  jenkins
  puppet
  prometheus
  vagrant
  terraform

  # Games
  aisleriot
  mari0
  kapman
  knights
  kmahjongg
  supertuxkart
  supertux
  extremetuxracer
  minetest
  minetest-server
  0ad
  teeworlds
  xonotic
  hedgewars

  # Graphics
  krita
  krita-plugin-gmic
  opencolorio
  gimp
  inkscape
  blender
  digikam
  darktable
  luminancehdr
  kolourpaint
  mypaint
  wings3d
  sweethome3d
  freecad
  librecad
  kicad
  pencil2d
  synfigstudio
  opentoonz
  fontforge
  birdfont

  # Internet
  xdman
  freedownloadmanager
  deluge-gtk
  qbittorrent
  nextcloud-client
  remmina
  filezilla
  putty
  warpinator
  nitroshare
  jdownloader2

  # Mail
  thunderbird
  kmail
  evolution
  geary
  mailspring
  claws-mail
  sylpheed

  # Multimedia
  hypnotix
  shortwave
  converseen
  handbrake
  mystiq
  transmageddon
  soundconverter
  stremio
  kodi
  kodi-platform
  kodi-eventclients
  mediaelch
  subtitlecomposer
  kid3
  easytag
  k3b
  cdparanoia
  cdrdao
  dvd+rw-tools
  emovix
  transcode
  vcdimager
  cdrtools
  brasero
  xfburn

  # Office
  libreoffice-fresh
  libmythes
  libreoffice-still
  libmythes
  joplin
  onlyoffice-bin
  wps-office
  wps-office-mime
  ttf-wps-fonts
  freeoffice
  yozo-office
  yozo-office-fonts
  calligra
  skrooge
  kmymoney
  abiword
  gnumeric
  gnucash
  homebank

  # Other
  scrcpy
  droidcam
  soundwire
  variety

  # Video
  kdenlive
  movit
  sox
  opus-tools
  frei0r-plugins
  opentimelineio
  dvgrab
  opencv
  dragon
  shotcut
  pitivi
  frei0r-plugins
  openshot
  obs-studio
  vlc
  smplayer
  smplayer-skins
  smplayer-themes
  baka-mplayer

  # Virtualization
  virtualbox
  gnome-boxes
  virt-manager
  genymotion
  # -----------------------------
  # yay packages
  # Media Tools
  gstreamer1-plugins-bad            # Bad set of GStreamer plugins (AUR)
  gstreamer1-plugins-good           # Good set of GStreamer plugins (AUR)
  gstreamer1-plugins-base           # Base set of GStreamer plugins (AUR)
  gstreamer1-plugin-openh264        # H.264 plugin for GStreamer (AUR)
  gstreamer1-libav                  # FFmpeg-based plugin for GStreamer (AUR)
  gstreamer1-plugins-bad-free-devel # Bad set of GStreamer plugins (development) (AUR)
  # 2.
  zsh-autosuggestions     # Fish-like autosuggestions for Zsh (AUR)
  zsh-syntax-highlighting # Fish shell-like syntax highlighting for Zsh (AUR)
  zsh-completions         # Additional completion definitions for Zsh (AUR)
  # 3.
  execstack         # Tool to disable/enable executable stack (AUR)
  pnpm              # Fast, disk space-efficient package manager (AUR)
  yarn              # JavaScript package manager (AUR)
  bun               # JavaScript runtime (AUR)
  libsoup           # HTTP client/server library (AUR)
  javascriptcoregtk # JavaScript engine for GTK (AUR)
  webkit2gtk        # Web content engine for GTK (AUR)
  grpc              # gRPC library (AUR)
  firewalld         # Firewall management tool (AUR)
  qemu              # Machine emulator (AUR)
  qemu-arch-extra   # Extra QEMU binary files (AUR)
  qemu-headless     # Headless mode of QEMU (AUR)

  # Additional AUR packages for system enhancement
  hyprland          # Hyprland window manager (AUR)
  swww              # Wallpaper manager for Wayland (AUR)
  swaybg            # Wallpaper utility for Wayland (AUR)
  swaylock          # Screen locker for Wayland (AUR)
  swayidle          # Idle management daemon for Wayland (AUR)
  waybar            # Status bar for Wayland (AUR)
  polkit-gnome      # GNOME authentication agent (AUR)
  libva-mesa-driver # Mesa drivers for VA-API (AUR)
  vulkan-radeon     # Vulkan driver for AMD GPUs (AUR)
  amdvlk            # AMD's official Vulkan driver (AUR)
  rpcs3             # PlayStation 3 emulator (AUR)
  steam             # Steam gaming platform (AUR)
  wine              # Compatibility layer for Windows applications (AUR)
  lutris            # Open gaming platform (AUR)
  mangohud          # Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load, etc. (AUR)
  govulncheck       # Go vulnerability checker (AUR)
  fuzzel            # Application launcher for Wayland (AUR)
  wl-clipboard      # Command-line clipboard tools for Wayland (AUR)
  ddcutil           # Control monitor settings (AUR)
  fprintd           # D-Bus service to access fingerprint readers (AUR)
  firewalld         # Firewall management tool (AUR)
  irqbalance        # Interrupt request (IRQ) balancer for SMP systems (AUR)
  tuned             # Dynamic adaptive system tuning daemon (AUR)
  tmate             # Instant terminal sharing (AUR)
  zram-generator    # Compressed RAM with ZRAM (AUR)

  # unSorted
  gedit vlc ffmpeg gstreamer gst-plugins-good gst-plugins-ugly libdvdcss gnome gnome-shell-extensions wayland xorg-server xf86-input-libinput mesa xf86-video-amdgpu linux-headers mesa lib32-mesa alacritty
  picom
  gnome-color-manager
  appmenu-gtk-module
  wl-clipboard
  git
  cmake
  sdl2
  sdl2_image
  sdl2_mixer
  sdl2_ttf
  openssl
  boost
  python
  mailcap
  python-nautilus
  bc cpio graphviz python-sphinx python-pyyaml texlive-latexextra
)

# Loop through each package in the allPackages Array
for package in "${allPackages[@]}"; do
  if pacman -Si "$package" &>/dev/null; then
    # Package exists in Pacman
    if ! pacman -Qi "$package" &>/dev/null; then
      # Package is not installed
      pacman_to_install+=("$package")
    else
      echo "Package '$package' is already installed via Pacman."
    fi
  elif yay -Si "$package" $ >/dev/null; then
    # Package exists in Yay (AUR)
    if ! yay -Q "$package" &>/dev/null; then
      # Package is not installed
      yay_to_install+=("$package")
    else
      echo "Package '$package' is already install via Yay."
    fi
  else
    echo "Package '$package' does not exist in Pacman or Yay."
  fi
done

# Install the missing packages via Pacman
if [ ${#pacman_to_install[@]} -gt 0 ]; then
  # shellcheck disable=SC2145
  echo "Installing the following packages via Pacman: ${pacman_to_install[@]}"
  sudo pacman -S --noconfirm "${pacman_to_install[@]}"
else
  echo "No missing packages to install via Pacman."
fi

# Install the missing packages via Yay
if [ ${#yay_to_install[@]} -gt 0 ]; then
  # shellcheck disable=SC2145
  echo "Installing the following packages via Yay: ${yay_to_install[@]}"
  yay -S --noconfirm "${yay_to_install[@]}"
else
  echo "No missing packages to install via Yay."
fi
# Install the missing packages via paru
echo "The suggested packages has been installed successfully."

sudo pacman -S linux-firmware linux-firmware-qlogic aic94xx-firmware wd719x-firmware


0ad a26-17
accountsservice 23.13.9-2
adobe-source-han-sans-cn-fonts 2.004-2
adobe-source-han-sans-jp-fonts 2.004-2
adobe-source-han-sans-kr-fonts 2.004-2
adwaita-color-schemes 0.9.2-1
adwaita-qt5 1.4.2-2
adwaita-qt6 1.4.2-2
aic94xx-firmware 30-10
alsa-firmware 1.2.4-4
alsa-plugins 1:1.2.12-4
alsa-utils 1.2.12-1
amd-ucode 20241017.22a6c7dc-1
amdvlk 2024.Q3.3-1
android-tools 35.0.2-6
anki 24.06.3-2
appmenu-gtk-module 24.05-1
arch-rebuild-order 0.4.4-1
arch-repro-status 1.4.1-2
arch-signoff 0.5.2-5
aribb25 0.2.7-3
asusctl 6.0.12-0.1
awesome-terminal-fonts 1.1.0-5
baobab 47.0-1
base 3-2
base-devel 1-2
bash-completion 2.14.0-2
bemenu 0.6.23-1
bemenu-wayland 0.6.23-1
bibata-cursor-theme 2.0.7-1
biber 1:2.19-4
bind 9.20.3-1
blas-openblas 0.3.28-1
blueman 2.4.3-1
bluez-hid2hci 5.79-1
bluez-libs 5.79-1
bluez-utils 5.79-1
boost 1.86.0-3
bpftune-git r528.04bab5d-1
bridge-utils 1.7.1-2
btop 1.4.0-4
btrfs-progs 6.11-1
bun-bin 1.1.34-1
busybox 1.36.1-2
cachy-chroot 1.2.0-1
cachyos-fish-config 15-1
cachyos-hello 0.14.9-1
cachyos-hooks 2024.03-1
cachyos-kernel-manager 1.10.2-1
cachyos-keyring 20240331-1
cachyos-micro-settings 1.0.0-1
cachyos-mirrorlist 18-1
cachyos-nord-gtk-theme-git r10.18b1535-1
cachyos-packageinstaller 1.3.4-2
cachyos-plymouth-theme 1-1
cachyos-rate-mirrors 8-1
cachyos-settings 1:1.1.4-1
cachyos-sysctl-manager 1.1.0-1
cachyos-v3-mirrorlist 18-1
cachyos-v4-mirrorlist 6-1
cachyos-wallpapers r12.0dd0efd-1
capitaine-cursors 4-3
cava 0.10.2-2
chwd 1.10.0-1
cpio 2.15-2
cppzmq 4.10.0-1
cpupower 6.10-5
cronie 1.7.2-1
cryptsetup 2.7.5-1
db 6.2.32-1
dblatex 0.3.12-11
device-mapper 2.03.28-1
dhclient 4.4.3.P1-3
dhcpcd 10.1.0-1
dialog 1:1.3_20240619-2
diffutils 3.10-1
discord 0.0.73-1
dkms 3.1.1-3
dmidecode 3.6-1
dmraid 1.0.0.rc16.3-15
dnsmasq 2.90-1
docker-scan 0.26.0-2
dos2unix 7.5.2-2
dosfstools 4.2-5
duf 0.8.1-3
dunst 1.11.0-1
dxvk-mingw-git 2.4.1.r420.gc466dec2-1
e2fsprogs 1.47.1-4
efibootmgr 18-3
efitools 1.9.2-5
eog 47.0-1
epiphany 47.2-1
ethtool 1:6.9-1
evince 46.3.1-2
exfatprogs 1.2.5-1
f2fs-tools 1.16.0-3
fcitx5 5.1.11-1
fcitx5-configtool 5.1.7-1
fcitx5-gtk 5.1.3-1
fcitx5-mozc 2.26.4632.102.g4d2e3bd-2
fcitx5-qt 5.1.8-1
fcitx5-unikey 5.1.5-1
ffmpegthumbnailer 2.2.3-3
firewalld 2.3.0-1
flatpak 1:1.15.10-1
fmt9 9.1.0-5
foliate 3.1.1-1
freedownloadmanager 6.24.2.5857-1
fsarchiver 0.8.7-2
gcc-fortran 14.2.1+r134+gab884fffe3fc-1
gedit 48.0-1
gimp 2.10.38-4
git 2.47.0-1
glances 4.2.1-1
gnome-backgrounds 47.0-1
gnome-bluetooth 3.34.5+r16+g61cfff1c-2
gnome-calculator 47.0-1
gnome-calendar 47.0-1
gnome-clocks 47.0-1
gnome-console 47.1-1
gnome-contacts 47.0-1
gnome-disk-utility 46.1-1
gnome-font-viewer 47.0-1
gnome-logs 45.0-1
gnome-menus 3.36.0-3
gnome-music 1:47.0-1
gnome-pomodoro-git r1314.4c4dc2b-1
gnome-remote-desktop 47.1-1
gnome-software 47.1-2
gnome-system-monitor 47.0-2
gnome-text-editor 47.1-1
gnome-themes-extra 3.28+r6+g45b1d457-2
gnome-tweaks 46.1-1
gnome-user-share 47.0-1
gnu-free-fonts 20120503-8
google-chrome 129.0.6668.100-1
gpart 0.3-5
gparted 1.6.0-2
gpu-screen-recorder-git r850.3e199f2-1
graphviz 12.1.2-1
grilo-plugins 1:0.3.16-1
gst-libav 1.24.9-2
gst-plugin-pipewire 1:1.2.6-1
gst-plugins-bad 1.24.9-2
gst-plugins-good 1.24.9-2
gst-plugins-ugly 1.24.9-2
gtk-chtheme 0.3.1-12
gtk-engine-murrine 0.98.2-4
gtk-engines 2.21.0-6
gtk-vnc 1.3.1-2
gum 0.14.5-1
gvfs-afc 1.56.1-1
gvfs-dnssd 1.56.1-1
gvfs-goa 1.56.1-1
gvfs-google 1.56.1-1
gvfs-gphoto2 1.56.1-1
gvfs-mtp 1.56.1-1
gvfs-nfs 1.56.1-1
gvfs-onedrive 1.56.1-1
gvfs-smb 1.56.1-1
gvfs-wsdd 1.56.1-1
hardcode-tray 4.3-3
haveged 1.9.19-1
hdparm 9.65-2
hitome-git r106.62300bb-1
hostapd 2.11-4
hwdetect 2024.07.29.0933-1
hwinfo 23.3-1
hyprcursor 0.1.10-1
hypridle 0.1.5-1
hyprland 0.44.1-4
hyprlang 0.5.3-1
hyprlock 0.5.0-1
hyprpaper 0.7.1-3
hyprpicker 0.4.1-1
hyprshot 1.3.0-1
hyprutils 0.2.3-1
hyprwayland-scanner 0.4.2-1
i8kutils 1.55-1
ibus 1.5.30-3
ibus-m17n 1.4.32-1
ifplugd 0.28-18
iftop 1.0pre4-6
illogical-impulse-ags r525.05e0f23-1
illogical-impulse-audio 1.0-1
illogical-impulse-backlight 1.0-1
illogical-impulse-basic 1.0-1
illogical-impulse-fonts-themes 1.0-1
illogical-impulse-gtk 1.0-1
illogical-impulse-oneui4-icons-git r64.9ba2190-1
illogical-impulse-pymyc-aur 1.0-1
illogical-impulse-python 1.0-1
illogical-impulse-screencapture 1.0-1
imv 4.5.0-4
inetutils 2.5-1
ipcalc 0.51-2
iperf 2.2.0-1
iperf3 3.17.1-1
ipguard 1.04-8
ipmitool 1.8.19-4
ipp-usb 0.9.28-1
ipset 7.22-1
iptables 1:1.8.10-2
iptraf-ng 1.2.1-2
iptstate 2.2.7-2
iptux 0.9.1-2
iputils-ping6-symlink 1.0.0-1
ipv6calc 4.1.0-2
ipvsadm 1.31-3
ipxe 1.21.1-5
ipython 8.29.0-1
iw 6.9-1
iwd 3.0-1
jdk-openjdk 23.0.1.u0-1
jfsutils 1.1.15-9
jpegoptim 1.5.5-3
kitty 0.37.0-1
kvantum 1.1.3-1
kvantum-qt5 1.1.3-1
kvantum-theme-nordic-git 2.2.0.r71.gff8165c-1
kwallet 6.7.0-1
less 1:661-1
lib32-alsa-plugins 1.2.12-1
lib32-fluidsynth 2.4.0-1
lib32-jack2 1.9.22-2
lib32-libavtp 0.2.0-3
lib32-libid3tag 0.16.3-1
lib32-libpulse 17.0-1
lib32-libsamplerate 0.2.2-3
lib32-libva-mesa-driver 1:24.2.4-1
lib32-mesa 1:24.2.4-1
lib32-mesa-vdpau 1:24.2.4-1
lib32-pipewire 1:1.2.6-1
lib32-speexdsp 1.2.1-2
lib32-vulkan-radeon 1:24.2.4-1
libdvdcss 1.4.3-2
libgoom2 2k4-5
libgsf 1.14.53-1
libkate 0.4.1-10
libopenraw 0.3.7-2
libtiger 0.3.4-8
libwnck3 43.1-1
libxdg-basedir 1.2.3-2
linux-cachyos 6.11.5-2
linux-cachyos-headers 6.11.5-2
linux-firmware 20241017.22a6c7dc-1
linux-firmware-qlogic 20241017.22a6c7dc-1
linux-hardened-headers 6.10.14.hardened1-1
linux-headers 6.11.6.arch1-1
linux-lts-headers 6.6.59-1
linux-zen-headers 6.11.6.zen1-1
live-media 2024.04.19-1
logrotate 3.22.0-1
loupe 47.1-1
lsb-release 2.0.r53.a86f885-2
lshw B.02.20-1
lsof 4.99.3-2
lsp-plugins-gst 1.2.19-1
lsscsi 0.32-2
lua-socket 1:3.1.0-1
lunacy-bin 10.0.1-1
lvm2 2.03.28-1
lxappearance 0.6.3-5
lynx 2.9.2-1
m-microtex-git r494.0e3707f-1
mailcap 2.1.54-2
man-db 2.13.0-1
man-pages 6.9.1-1
matugen-bin 2.3.0-1
mdadm 4.3-2
meld 3.22.2-3
mesa-utils 9.0.0-5
micro 2.0.14-1
microsoft-edge-stable-bin 129.0.2792.89-1
mkinitcpio 39.2-2
mono 6.12.0.206-1
motrix 1.8.19-3
mousepad 0.6.3-2
mplayer 38542-4
mpv 1:0.39.0-3
mpv-mpris 1.1-3
mtools 1:4.0.45-1
mupdf-tools 1.24.10-2
mutter-cachyos 47.0-1
nano 8.2-1
nano-syntax-highlighting 2022.11.02.r102.gbb94603-1
nautilus 47.0-3
net-tools 2.10-3
netctl 1.29-2
network-manager-applet 1.36.0-1
networkmanager-openconnect 1.2.10-2
nfs-utils 2.8.1-1
nilfs-utils 2.2.11-1
nixpkgs-fmt 1.3.0-2
nm-connection-editor 1.36.0-1
nmap 7.95-1
noto-color-emoji-fontconfig 1.0.0-2
noto-fonts 1:2024.11.01-1
noto-fonts-cjk 20230817-2
noto-fonts-emoji 1:2.047-1
nss-mdns 0.15.1-2
ntfs-3g 2022.10.3-1
ntp 4.2.8.p18-2
nvtop 3.1.0-1
nwg-look 0.2.7-1
obsidian 1.7.5-2
octopi 0.16.2-2
opencl-clhpp 2024.05.08-1
opendesktop-fonts 1.4.2-7
openh264 2.4.1-1
openresolv 3.13.2-2
openssh 9.9p1-2
orca 47.1-1
pacman-contrib 1.10.6-2
pacquery 0.0.3-1
pamixer 1.6-3
papirus-folders 1.13.1-1
papirus-icon-theme 20240501-1
paru 2.0.4-1
pax-utils 1.3.8-1
perl 5.40.0-1
perl-image-exiftool 13.02-1
perl-tk 804.036-7
picom 12.3-2
pigz 2.8-2
pipewire-alsa 1:1.2.6-1
pipewire-pulse 1:1.2.6-1
plocate 1.1.22-3
plymouth 24.004.60-9
polkit-kde-agent 6.2.3-1
pomodoro r22.41b74d5-1
poppler-glib 24.09.0-4
power-profiles-daemon 0.23-2
profile-sync-daemon 1:6.50-2
projectm 3.1.12-5
psutils 3.3.5-1
pv 1.9.0-1
python 3.12.7-1
python-anyascii 0.3.2-2
python-defusedxml 0.7.1-6
python-nautilus 4.0-3
python-numpy 2.1.3-1
python-objgraph 3.6.2-1
python-packaging 24.1-1
python-pip 24.3.1-1
python-pipx 1.6.0-1
python-pygments 2.18.0-1
python-pylint 3.3.1-1
python-pyqt5 5.15.11-1
python-pyquery 2.0.0-4
python-selenium 4.26.1-1
qbittorrent 5.0.1-1
qt5-3d 5.15.15-1
qt5-charts 5.15.15-1
qt5-connectivity 5.15.15+kde+r3-1
qt5-datavis3d 5.15.15-1
qt5-doc 5.15.15-1
qt5-examples 5.15.15-1
qt5-gamepad 5.15.15-2
qt5-graphicaleffects 5.15.15-1
qt5-imageformats 5.15.15+kde+r4-1
qt5-location 5.15.15+kde+r7-1
qt5-lottie 5.15.15-2
qt5-multimedia 5.15.15+kde+r2-1
qt5-networkauth 5.15.15+kde+r1-1
qt5-purchasing 5.15.15-2
qt5-quick3d 5.15.15+kde+r1-1
qt5-quickcontrols 5.15.15-1
qt5-quickcontrols2 5.15.15+kde+r5-1
qt5-quicktimeline 5.15.15-2
qt5-remoteobjects 5.15.15-1
qt5-script 5.15.18-1
qt5-scxml 5.15.15-1
qt5-sensors 5.15.15-1
qt5-serialbus 5.15.15-1
qt5-serialport 5.15.15-1
qt5-speech 5.15.15+kde+r1-1
qt5-tools 5.15.15+kde+r3-2
qt5-virtualkeyboard 5.15.15-1
qt5-webchannel 5.15.15+kde+r3-1
qt5-webengine 5.15.18-2
qt5-webglplugin 5.15.15-2
qt5-websockets 5.15.15+kde+r2-1
qt5-webview 5.15.15-2
qt5-xmlpatterns 5.15.15-1
qt6-3d 6.8.0-1
qt6-charts 6.8.0-1
qt6-connectivity 6.8.0-1
qt6-datavis3d 6.8.0-1
qt6-graphs 6.8.0-1
qt6-grpc 6.8.0-1
qt6-httpserver 6.8.0-1
qt6-imageformats 6.8.0-1
qt6-languageserver 6.8.0-2
qt6-location 6.8.0-1
qt6-lottie 6.8.0-1
qt6-networkauth 6.8.0-1
qt6-quick3d 6.8.0-1
qt6-quick3dphysics 6.8.0-1
qt6-quickeffectmaker 6.8.0-1
qt6-quicktimeline 6.8.0-1
qt6-remoteobjects 6.8.0-1
qt6-scxml 6.8.0-1
qt6-serialbus 6.8.0-1
qt6-serialport 6.8.0-1
qt6-webview 6.8.0-1
qt6ct 0.9-11
r 4.4.2-1
radvd 2.19-2
raindrop 5.6.50-1
rebuild-detector 4.4.4-1
reflector 2023-2
rtkit 0.13-3
rust-analyzer 20241104-1
rust-src 1:1.82.0-2
rygel 1:0.44.1-1
s-nail 14.9.24-2
scrcpy 2.7-2
sct 1.0.0-1
sddm 0.21.0-6
sddm-theme-corners-git r40.6ff0ff4-1
sdl12-compat 1.2.68-2
sdl2_image 2.8.2-6
sdl2_mixer 2.8.0-1
sdl2_ttf 2.22.0-1
sdl_image 1.2.12-9
sg3_utils 1.48-1
simple-scan 46.0-2
smartmontools 7.4-2
snapshot 47.1-1
sof-firmware 2024.09.1-1
spoof-dpi-bin 0.10.11-2
sudo 1.9.16-1
supergfxctl 5.2.4-1
sushi 46.0-2
swaybg 1.2.1-1
swaylock-effects-git r470.496059a-1
swaylock-fancy-git r233.b1e86a0-1
swaync 0.10.1-3
sysfsutils 2.1.1-2
systemd-boot-manager 14-1
tcpdump 4.99.5-1
texinfo 7.1.1-1
totem 43.1-1
tree 2.1.3-1
ttf-bitstream-vera 1.10-16
ttf-dejavu 2.37+18+g9b5d1b2f-7
ttf-droid 20121017-11
ttf-fira-code 6.2-2
ttf-font-awesome 6.6.0-1
ttf-google-sans 1-4
ttf-jetbrains-mono 2.304-2
ttf-liberation 2.1.5-2
ttf-meslo-nerd 3.2.1-2
ttf-meslo-nerd-font-powerlevel10k 2.3.3-1
ttf-opensans 1.101-3
ttf-roboto 2.138-5
udftools 2.3-2
udiskie 2.5.3-1
ufw 0.36.2-4
ulauncher 5.15.7-1
unixodbc 2.3.12-2
unrar 1:7.1.1-1
unzip 6.0-21
usb_modeswitch 2.6.1-4
usbutils 018-1
uwsgi 2.0.28-1
vcdimager 2.0.1-4
ventoy-bin 1.0.99-1
vi 1:070224-6
vim 9.1.0785-1
visual-studio-code-bin 1.94.2-1
vkd3d 1.11-1
vlc 3.0.21-7
vulkan-radeon 1:24.2.4-1
vulkan-tools 1.3.269-1
wallust 3.0.0-1
wayland-utils 1.2.0-2
wayshot 1.3.1-2
wd719x-firmware 1-7
which 2.21-6
wine 9.20-1
wine-gecko 2.47.4-2
wine-mono 9.3.0-1
winetricks 20240105-1
wireless_tools 30.pre9-4
wl-gammarelay 0.1.0-1
wl-gammarelay-rs 0.4.1-1
wlroots 0.18.1-1
wob 0.15.1-2
wofi 1.4.1-1
xarchiver 0.5.4.23-1
xclip 0.13-5
xdg-desktop-portal-hyprland 1.3.8-1
xdg-utils 1.2.1-1
xdm 0.4.1-1
xdman-beta-bin 8.0.29-8
xf86-input-libinput 1.5.0-1
xf86-video-amdgpu 23.0.0-2
xfce4-clipman-plugin 1.6.6-3
xfsprogs 6.11.0-1
xorg-mkfontscale 1.2.3-1
xorg-server 21.1.14-1
xorg-xdpyinfo 1.3.4-2
xorg-xhost 1.0.9-2
xorg-xinit 1.4.2-2
xorg-xinput 1.6.4-2
xorg-xkill 1.0.6-2
xorg-xrandr 1.5.3-1
xorg-xwayland 24.1.4-1
xorg-xwininfo 1.1.6-2
yay 12.4.2-1
yelp 42.2-2
youtube-dl 2021.12.17-3
yt-dlp 2024.11.04-1
zsh 5.9-5
zsh-completions 0.35.0-2
zsh-doc 5.9-5
zsh-syntax-highlighting 0.8.0-1