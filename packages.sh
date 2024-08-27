#!/bin/bash
# ------------------------------------ #
# Script to install suggested packages #
# ------------------------------------ #

# Update system packages
sudo pacman -Syu --noconfirm
sudo pacman -Fy --noconfirm
yay -Syu --noconfirm

echo "Starting installation of suggested packages..."
# 1. Text Editor
sudo pacman -S --needed gedit  # Simple text editor for GNOME

# 2. Media Tools
sudo pacman -S --needed \
    vlc \                  # Multimedia player
    ffmpeg \               # Multimedia framework
    gstreamer \            # Media framework
    gst-plugins-good \     # Good set of GStreamer plugins
    gst-plugins-ugly \     # Ugly set of GStreamer plugins
    libdvdcss              # Library for accessing encrypted DVDs

yay -S --needed \
    gstreamer1-plugins-bad \             # Bad set of GStreamer plugins (AUR)
    gstreamer1-plugins-good \            # Good set of GStreamer plugins (AUR)
    gstreamer1-plugins-base \            # Base set of GStreamer plugins (AUR)
    gstreamer1-plugin-openh264 \         # H.264 plugin for GStreamer (AUR)
    gstreamer1-libav \                   # FFmpeg-based plugin for GStreamer (AUR)
    gstreamer1-plugins-bad-free-devel    # Bad set of GStreamer plugins (development) (AUR)

# 3. GNOME Desktop Environment
sudo pacman -S --needed
    gnome \                   # GNOME desktop environment
    gnome-shell-extensions \  # Extensions for GNOME Shell
    gnome-tweaks \            # GNOME tweaking tool
    gnome-extensions-app \    # Manage GNOME Shell extensions
    gnome-keyring \           # GNOME keyring management
    gnome-control-center      # GNOME Control Center

# 4. Display Server and Graphics
sudo pacman -S --needed \
    wayland \              # Wayland display server protocol
    xorg-server \          # X.Org server
    xf86-input-libinput \  # Input driver for X.Org
    mesa \                 # Mesa 3D graphics library
    xf86-video-amdgpu \    # AMD GPU driver for X.Org
    qt6-wayland \          # Qt6 Wayland platform plugin
    gtk3 \                 # GTK3 library
    libnotify \            # Notification library
    libcap \               # POSIX capabilities library
    libxtst \              # X11 Test extension library
    libxrandr              # X11 RandR extension library

# 5. Hyprland and Wayland-Related Packages
sudo pacman -S --needed \
    hyprland \             # Hyprland window manager
    waybar \               # Highly customizable status bar for Wayland
    swaylock-effects \     # Screen locker for Wayland with fancy effects
    wofi \                 # Application launcher for Wayland
    xdg-desktop-portal-hyprland  # Desktop portal for Hyprland

# 6. Terminal Enhancements
sudo pacman -S --needed \
    alacritty \            # Terminal emulator
    kitty \                # Terminal emulator
    tmux \                 # Terminal multiplexer
    powerlevel10k \        # Zsh theme
    lsd \                  # Modern replacement for 'ls'
    fzf \                  # Command-line fuzzy finder
    bat \                  # Cat clone with syntax highlighting
    exa \                  # Modern replacement for 'ls'
    fd \                   # Simple, fast alternative to 'find'
    ripgrep                # Line-oriented search tool

yay -S --needed \
    zsh-autosuggestions \  # Fish-like autosuggestions for Zsh (AUR)
    zsh-syntax-highlighting \  # Fish shell-like syntax highlighting for Zsh (AUR)
    zsh-completions        # Additional completion definitions for Zsh (AUR)

# 7. Development Tools
sudo pacman -S --needed \
    neovim \               # Text editor
    code \                 # Visual Studio Code
    intellij-idea-community-edition \  # IntelliJ IDEA Community Edition
    clang \                # C language family frontend
    gdb \                  # GNU Debugger
    cmake \                # Cross-platform build system
    ninja \                # Build system
    docker \               # Container platform
    podman \               # Manage pods, containers, and images
    git-lfs \              # Git extension for versioning large files
    kubectl \              # Kubernetes command-line tool
    gradle \               # Build automation tool
    python-pip \           # Python package installer
    rustup \               # Rust toolchain installer
    gcc \                  # GNU Compiler Collection
    corectrl \             # Graphical system management tool
    devscripts \           # Scripts for Debian development
    ncurses \              # Terminal handling library
    qt5-webengine \        # Web engine for Qt5
    pkg-config \           # Manage compile and link flags for libraries
    boost \                # C++ library
    gperf \                # Perfect hash function generator
    gtkmm3 \               # C++ bindings for GTK3
    base-devel \           # Development tools (make, gcc, etc.)
    ttf-liberation         # Liberation fonts

yay -S --needed \
    execstack \            # Tool to disable/enable executable stack (AUR)
    pnpm \                 # Fast, disk space-efficient package manager (AUR)
    yarn \                 # JavaScript package manager (AUR)
    bun \                  # JavaScript runtime (AUR)
    libsoup \              # HTTP client/server library (AUR)
    javascriptcoregtk \    # JavaScript engine for GTK (AUR)
    webkit2gtk \           # Web content engine for GTK (AUR)
    grpc \                 # gRPC library (AUR)
    firewalld \            # Firewall management tool (AUR)
    qemu \                 # Machine emulator (AUR)
    qemu-arch-extra \      # Extra QEMU binary files (AUR)
    qemu-headless          # Headless mode of QEMU (AUR)

# 8. Performance and Optimization
sudo pacman -S --needed \
    earlyoom \             # Out-of-memory management
    thermald \             # Thermal management
    tlp \                  # Power management
    cpupower \             # CPU power management
    iotop \                # Display I/O usage
    htop \                 # Interactive process viewer
    btop \                 # Resource monitor
    preload \              # Adaptive readahead daemon
    zram-generator         # Compressed RAM with ZRAM

# 9. General Utilities
sudo pacman -S --needed \
    syncthing \            # Continuous file synchronization
    ranger \               # Terminal file manager
    ncdu \                 # Disk usage analyzer
    bleachbit \            # System cleaner
    gparted \              # Partition editor
    timeshift \            # System restore tool
    resolvconf \           # DNS resolution manager
    gnome-disks            # Manage disk drives and media

# 10. Additional Utilities
sudo pacman -S --needed \
    grub-customizer \      # GUI tool to configure GRUB2
    networkmanager-tui \   # Text user interface for NetworkManager
    aircrack-ng \          # Wireless network security tools
    hcxtools \             # WPA/WPA2/PMKID penetration testing toolkit
    dbus \                 # Message bus system
    qt5-base \             # Qt5 base library
    libglvnd \             # Vendor-neutral OpenGL dispatch library
    atk \                  # Accessibility Toolkit
    at-spi2-core \         # Assistive Technology Service Provider Interface
    gvfs-mtp \             # MTP filesystem support for GVFS
    android-tools \        # Android platform tools
    wireplumber \          # Audio and video routing system
    pavucontrol \          # PulseAudio volume control
    playerctl \            # Media player controller
    webp-pixbuf-loader \   # WebP image loader for GdkPixbuf
    gtk-layer-shell \      # Library to create Wayland popups
    yad \                  # Yet Another Dialog
    ydotool \              # Generic command-line automation tool
    polkit-gnome \         # GNOME authentication agent
    gnome-bluetooth-3.0 \  # GNOME Bluetooth tools
    brightnessctl \        # Control device brightness
    ddcutil \              # Control monitor settings
    dart-sass \            # Dart Sass compiler
    python-pywayland \     # Python bindings for the Wayland protocol
    python-psutil \        # Cross-platform process and system utilities
    hyprpicker-git \       # Color picker for Hyprland
    anyrun-git \           # Run anything from your terminal
    adw-gtk3-git \         # Adwaita theme for GTK3
    qt5ct \                # Qt5 Configuration Tool
    fontconfig \           # Font configuration and customization library
    ttf-jetbrains-mono-nerd \ # Nerd Font patched JetBrains Mono
    fish \                 # Friendly interactive shell
    foot \                 # Wayland terminal emulator
    starship \             # Cross-shell prompt for astronauts
    swappy \               # Wayland screenshot editor
    rustup \               # Rust toolchain installer
    yad \                  # Yet Another Dialog
    mpv \                  # Media player
    xdg-desktop-portal     # Desktop integration portal

# 11. Additional AUR packages for system enhancement
yay -S --needed \
    hyprland \              # Hyprland window manager (AUR)
    swww \                 # Wallpaper manager for Wayland (AUR)
    swaybg \               # Wallpaper utility for Wayland (AUR)
    swaylock \             # Screen locker for Wayland (AUR)
    swayidle \             # Idle management daemon for Wayland (AUR)
    waybar \               # Status bar for Wayland (AUR)
    polkit-gnome \         # GNOME authentication agent (AUR)
    libva-mesa-driver \    # Mesa drivers for VA-API (AUR)
    vulkan-radeon \        # Vulkan driver for AMD GPUs (AUR)
    amdvlk \               # AMD's official Vulkan driver (AUR)
    rpcs3 \                # PlayStation 3 emulator (AUR)
    steam \                # Steam gaming platform (AUR)
    wine \                 # Compatibility layer for Windows applications (AUR)
    lutris \               # Open gaming platform (AUR)
    mangohud \             # Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load, etc. (AUR)
    govulncheck \          # Go vulnerability checker (AUR)
    fuzzel \               # Application launcher for Wayland (AUR)
    wl-clipboard \         # Command-line clipboard tools for Wayland (AUR)
    ddcutil \              # Control monitor settings (AUR)
    fprintd \              # D-Bus service to access fingerprint readers (AUR)
    firewalld \            # Firewall management tool (AUR)
    irqbalance \           # Interrupt request (IRQ) balancer for SMP systems (AUR)
    tuned \                # Dynamic adaptive system tuning daemon (AUR)
    tmate \                # Instant terminal sharing (AUR)
    zram-generator         # Compressed RAM with ZRAM (AUR)

echo "Installation complete!"
