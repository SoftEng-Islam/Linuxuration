# Edit this configuration file to define what should be installed on your system.
# Help is available in the configuration.nix(5) man page, Or by running ‘nixos-help’.
{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      # /home/softeng/nixpkgs/fdm.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    "amdgpu.gpu_recovery=1"
    "amdgpu.dc=1"
    "amdgpu.dpm=1"
    "radeon.si_support=0"
    "amdgpu.si_support=1"
    "nopat"
    "mitigations=off"
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true; # Enable IPv4 forwarding
    "vm.swappiness" = 60;
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
  };
  # boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nix = {
    package = pkgs.nixStable;
    extraOptions = ''
      experimental-features = nix-command flakes
      http2 = false
    '';
  };
  # Nix Packages configuration
  nixpkgs.config.allowUnfree = true; # Allow unfree packages
  nixpkgs.config.rocmSupport = true;

  # Hardware Options
  hardware.amdgpu.initrd.enable = false;
  hardware.amdgpu.legacySupport.enable = true;
  hardware.amdgpu.opencl.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.enable = false; # Enable sound with pipewire.
  hardware.pulseaudio.support32Bit = false;
  hardware.enableAllFirmware = false;
  hardware.amdgpu.amdvlk.enable = true;
  hardware.amdgpu.amdvlk.support32Bit.enable = true;

  # Power Management
  powerManagement.enable = true;
  # powerManagement.powertop.enable = true; # enable powertop auto tuning on startup.
  powerManagement.cpuFreqGovernor = "performance"; # Often used values: “ondemand”, “powersave”, “performance”
  # powerManagement.cpufreq.min = 800000;
  # powerManagement.cpufreq.max = 2200000;

  # Environment
  environment.memoryAllocator.provider = "jemalloc"; # The system-wide memory allocator.

  # Security
  security.allowSimultaneousMultithreading = false; # to allow SMT/hyperthreading
  security.sudo.extraConfig = "Defaults        env_reset,pwfeedback"; # show Password as stars in Terminals.
  security.rtkit.enable = true;

  # Virtualisation
  virtualisation.libvirtd.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    enableIPv6 = true;
    firewall.enable = false; # Enable the firewall
    #wireless.enable = true; # Enables wireless support via wpa_supplicant.
    firewall.extraCommands = ''
      iptables -t nat -A POSTROUTING -o wlp0s16f0u1 -j MASQUERADE
      iptables -A FORWARD -i wlp0s16f0u1 -o eno1 -m state --state RELATED,ESTABLISHED -j ACCEPT
      iptables -A FORWARD -i eno1 -o wlp0s16f0u1 -j ACCEPT
    '';
  };
  networking.wireless.iwd.settings = {
    Network = {
      EnableIPv6 = true;
      RoutePriorityOffset = 300;
    };
    Settings = {
      AutoConnect = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Africa/Cairo";
  # Select Internationalisation Properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_EG.UTF-8";
    LC_IDENTIFICATION = "ar_EG.UTF-8";
    LC_MEASUREMENT = "ar_EG.UTF-8";
    LC_MONETARY = "ar_EG.UTF-8";
    LC_NAME = "ar_EG.UTF-8";
    LC_NUMERIC = "ar_EG.UTF-8";
    LC_PAPER = "ar_EG.UTF-8";
    LC_TELEPHONE = "ar_EG.UTF-8";
    LC_TIME = "ar_EG.UTF-8";
  };
  console = {
    packages = [ pkgs.terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.softeng = {
    isNormalUser = true;
    description = "softeng";
    shell = pkgs.zsh; # Set zsh as the default shell
    extraGroups = [
      "flatpak"
      "disk"
      "qemu"
      "kvm"
      "libvirtd"
      "sshd"
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "root"
    ];
    packages = with pkgs; [
      # thunderbird
    ];
  };
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      jetbrains-mono
      (nerdfonts.override { fonts = [ "Meslo" ]; }) # You can also override this with JetBrains Mono Nerd Font if desired
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrains Mono" ];
        serif = [ "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Noto Sans" "Source Han Sans" ];
      };
    };
  };
  # Services
  services.libinput.mouse.accelSpeed = "-0.5";
  services.xserver.enable = true; # Enable the X11 windowing system.
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.displayManager.gdm.enable = true; # Enable GDM Display Manager
  services.xserver.desktopManager.gnome.enable = true; # Enable the GNOME Desktop Environment.
  services.printing.enable = true; # Enable CUPS to print documents.
  services.picom.enable = true;
  services.picom.vSync = true;

  # services.beesd.enable = true;
  # services.beesd.filesystems = {
  #   root = {
  #     spec = "LABEL=root";
  #     hashTableSizeMB = 2048;
  #     verbosity = "crit";
  #     extraOptions = [ "--loadavg-target" "5.0" ];
  #   };
  # }
  # services.beesd.filesystems.btrfs = {
  #   spec = "/path/to/your/btrfs"; # Replace with your actual Btrfs mount point
  #   hashTableSizeMB = 1024; # Adjust as needed
  # };
  # services.beesd.filesystems.xfs.hashTableSizeMB = 1024;


  # services.ollama.acceleration = "rocm";
  # services.ollama.rocmOverrideGfx = "your-apu-gfx-version"; # replace with actual GFX
  # To get GFX:
  ##- sudo rm -rf /nix/var/nix/temproots/*
  ##- sudo nix-shell -p rocmPackages.rocminfo --run "rocminfo" | grep "gfx"

  services.cpupower-gui.enable = true;
  services.thermald.enable = true;  # Manages CPU temperature and prevents overheating
  networking.wireless.iwd.enable = true;     # Intel wireless daemon (works with some AMD chipsets too)

  # services.xserver.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
  # Enable Hyprland
  services.xserver.xkb = {
    # Configure keymap in X11
    layout = "us";
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };
  # List services that you want to enable:
  services.openssh.enable = true; # Enable the OpenSSH daemon.
  services.resolved.enable = false; # Whether to enable the systemd DNS resolver daemon, systemd-resolved.

  services.dnsmasq = {
    # Configure dnsmasq
    enable = true;
    settings = {
      # interface = "eno1"; # Listen on the eno1 interface
      # domain-needed = true;
      # bogus-priv = true;
      # server = [ "8.8.8.8" "8.8.4.4" ]; # DNS servers
    };
  };

  # Programes
  programs.corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.corectrl.enable = true; # a tool to overclock amd graphics cards and processors. 
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableLsColors = true;
  programs.fzf.fuzzyCompletion = true;
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [
      # "git"
      # "zsh-git-prompt"
      # "fzf-zsh"
      # "zsh-fzf-tab"
      # "zsh-completions"
      # "zsh-autocomplete"
      # "zsh-autosuggestions"
      # "zsh-syntax-highlighting"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    sudo
    # ----------- Editors ----------- #
    curl # A command line tool for transferring files with URL syntax
    vim # The most popular clone of the VI editor
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    gedit # Former GNOME text editor
    vscode # Open source source code editor developed by Microsoft for Windows, Linux and macOS
    # ----------- Terminals ----------- #
    bash # GNU Bourne-Again Shell, the de facto standard shell on Linux
    kitty # A modern, hackable, featureful, OpenGL based terminal emulator
    foot # A fast, lightweight and minimalistic Wayland terminal emulator
    zsh # The Z shell
    zsh-git-prompt # Informative git prompt for zsh
    fzf # Command-line fuzzy finder written in Go
    fzf-zsh # wrap fzf to use in oh-my-zsh
    zsh-fzf-tab # Replace zsh's default completion selection menu with fzf!
    zsh-completions # Additional completion definitions for zsh
    zsh-autocomplete # Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion
    zsh-autosuggestions # Fish shell autosuggestions for Zsh
    zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
    oh-my-zsh # A framework for managing your zsh configuration 
    eza # A modern, maintained replacement for ls
    # ----------- Browsers ----------- #
    google-chrome # Freeware web browser developed by Google
    #microsoft-edge # The web browser from Microsoft
    # ----------- Networking ----------- #
    dnsmasq # An integrated DNS, DHCP and TFTP server for small networks
    dhcpcd # A client for the Dynamic Host Configuration Protocol (DHCP)
    dhcping # Send DHCP request to find out if a DHCP server is running
    firewalld # Firewall daemon with D-Bus interface
    firewalld-gui # Firewall daemon with D-Bus interface
    iproute2 # A collection of utilities for controlling TCP/IP networking and traffic control in Linux
    iptables # A program to configure the Linux IP packet filtering ruleset
    iptables-legacy # A program to configure the Linux IP packet filtering ruleset
    networkd-dispatcher # Dispatcher service for systemd-networkd connection status changes
    trust-dns # A Rust based DNS client, server, and resolver
    routedns # DNS stub resolver, proxy and router
    hostapd # A user space daemon for access point and authentication servers
    iwd # Wireless daemon for Linux
    # ----------- Notes ----------- #
    obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
    # ----------- Media ----------- #
    openh264 # A codec library which supports H.264 encoding and decoding
    xvidcore # MPEG-4 video codec for PC
    ab-av1 # AV1 re-encoding using ffmpeg, svt-av1 & vmaf
    svt-av1 # AV1-compliant encoder/decoder library core
    rav1e # The fastest and safest AV1 encoder
    libaom # Alliance for Open Media AV1 codec library
    gst_all_1.gstreamer # Open source multimedia framework
    gst_all_1.gst-plugins-ugly # Gstreamer Ugly Plugins
    gst_all_1.gst-plugins-good # GStreamer Good Plugins
    gst_all_1.gst-plugins-bad # GStreamer Bad Plugins
    gst_all_1.gst-plugins-rs # GStreamer plugins written in Rust
    gst_all_1.gst-libav # FFmpeg/libav plugin for GStreamer
    gst_all_1.gst-plugins-base # Base GStreamer plug-ins and helper libraries
    mpv # General-purpose media player, fork of MPlayer and mplayer2
    vlc # Cross-platform media player and streaming server
    glide-media-player # Linux/macOS media player based on GStreamer and GTK
    clapper # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
    # ----------- Nix Stuff ----------- #
    fmt # Small, safe and fast formatting library
    nixpkgs-fmt # Nix code formatter for nixpkgs
    dpkg # The Debian package manager
    rpm # The RPM Package Manager
    pacman # A simple library-based package manager
    flatpak # Linux application sandboxing and distribution framework
    # ----------- Icons & Themes ----------- #
    papirus-icon-theme # Pixel perfect icon theme for Linux
    # ----------- Social ----------- #
    discord # All-in-one cross-platform voice and text chat for gamers
    # ----------- Disks & Partitions #
    fuse3 # Library that allows filesystems to be implemented in user space
    ntfs3g # FUSE-based NTFS driver with full write support
    efibootmgr # A Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager
    # ----------- CLI Tools ----------- #
    lsof # A tool to list open files
    yt-dlp # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
    # ----------- Hacking & security Tools ----------- #
    hashcat # Fast password cracker
    hashcat-utils # Small utilities that are useful in advanced password cracking
    hcxtools # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
    # ----------- Gnome Stuff ----------- #
    gnome.eog # GNOME image viewer
    gnome.totem # Movie player for the GNOME desktop based on GStreamer
    gnome-usage # A nice way to view information about use of system resources, like memory and disk space
    gnome.gpaste # Clipboard management system with GNOME integration
    gnome-photos # Access, organize and share your photos
    gnome.gnome-tweaks # A tool to customize advanced GNOME 3 options
    gnome.pomodoro # Time management utility for GNOME based on the pomodoro technique
    gnome-recipes # Recipe management application for GNOME
    gnome-extension-manager # Desktop app for managing GNOME shell extensions
    gnome.gnome-chess # Play the classic two-player boardgame of chess
    # to-Do & time & tasks apps
    # pomodoro-gtk # A simple and intuitive timer application (also named Planytimer)
    # (import /home/softeng/nixpkgs/fdm.nix { inherit pkgs; })
    # ----------- Hyprland ----------- #
    hyprland # A dynamic tiling Wayland compositor that doesn't sacrifice on its looks
    hyprland-protocols # Wayland protocol extensions for Hyprland
    hyprlandPlugins.hyprexpo # Hyprland workspaces overview plugin
    hyprlandPlugins.hyprbars # Plugins can be installed via a plugin entry in the Hyprland NixOS or Home Manager options.
    xdg-desktop-portal-hyprland # xdg-desktop-portal backend for Hyprland
    grimblast # A helper for screenshots within Hyprland, based on grimshot
    fd # A simple, fast and user-friendly alternative to find
    brightnessctl # This program allows you read and control device brightness
    swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    matugen # A material you color generation tool
    hyprpicker # A wlroots-compatible Wayland color picker that does not suck
    slurp # Select a region in a Wayland compositor
    wf-recorder # Utility program for screen recording of wlroots-based compositors
    wl-clipboard # Command-line copy/paste utilities for Wayland
    wayshot # A native, blazing-fast screenshot tool for wlroots based compositors such as sway and river
    swappy # A Wayland native snapshot editing tool, inspired by Snappy on macOS
    # asusctl # A control daemon, CLI tools, and a collection of crates for interacting with ASUS ROG laptops
    # supergfxctl # A GPU switching utility, mostly for ASUS laptops
    # Android
    waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
    # Windows
    wine # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    wine64 # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    winetricks # A script to install DLLs needed to work around problems in Wine
    # Downloaders
    qbittorrent # Featureful free software BitTorrent client
    # Programming Langauges & Frameworks & Tools
    rustup # The Rust toolchain installer
    cargo-tauri # Build smaller, faster, and more secure desktop applications with a web frontend
    nodejs_22 # Event-driven I/O framework for the V8 JavaScript engine
    bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
    git # Distributed version control system
    dart-sass # The reference implementation of Sass, written in Dart
    # Drivers
    hwdata # Hardware Database, including Monitors, pci.ids, usb.ids, and video cards
    libva # An implementation for VA-API (Video Acceleration API)
    libdrm # Direct Rendering Manager library and headers
    linuxKernel.packages.linux_6_11.amdgpu-pro # AMDGPU-PRO drivers
    opencl-clhpp # OpenCL Host API C++ bindings
    vulkan-loader # LunarG Vulkan loader
    gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    lm_sensors # For monitoring temperatures and voltages
    amdvlk # AMD Open Source Driver For Vulkan
    driversi686Linux.amdvlk # AMD Open Source Driver For Vulkan
    amd-blis # BLAS-compatible library optimized for AMD CPUs
    rocmPackages.rocm-smi # System management interface for AMD GPUs supported by ROCm
    rocmPackages.clr # AMD Common Language Runtime for hipamd, opencl, and rocclr
    rocmPackages.hipcc # Compiler driver utility that calls clang or nvcc
    rocmPackages.clang-ocl # OpenCL compilation with clang compiler
    rocmPackages.rocm-thunk # Radeon open compute thunk interface
    opencl-info # A tool to dump OpenCL platform/device information
    opencl-clhpp # OpenCL Host API C++ bindings
    opencl-clang # A clang wrapper library with an OpenCL-oriented API and the ability to compile OpenCL C kernels to SPIR-V modules
    clinfo # Print all known information about all available OpenCL platforms and devices in the system
    mesa # An open source 3D graphics library
    # 3D Tools & Applications
    blender-hip # 3D Creation/Animation/Publishing System
    # ----------- Games ----------- #
    zeroadPackages.zeroad-unwrapped
    zeroadPackages.zeroad-data
    # System Tools
    resources # Monitor your system resources and processes
    mangohud # A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
    openssl # A cryptographic library that implements the SSL and TLS protocols
    xdg-utils # A set of command line tools that assist applications with a variety of desktop integration tasks
    ffmpeg # A complete, cross-platform solution to record, convert and stream audio and video
    busybox # Tiny versions of common UNIX utilities in a single small executable
    flatpak # Linux application sandboxing and distribution framework
  ];
  system.stateVersion = "24.05";
}
