# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;




  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    enableIPv6 = false;
    #firewall.enable = false;

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  };



  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.softeng = {
    isNormalUser = true;
    description = "softeng";
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
      "libvirtd"
      "root"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;




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


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Editors
    vim # The most popular clone of the VI editor
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    gedit # Former GNOME text editor
    vscode # Open source source code editor developed by Microsoft for Windows, Linux and macOS
    # Terminals
    kitty
    foot
    # Browsers
    google-chrome
    # microsoft-edge

    # Networking
    dnsmasq

    # Notes
    obsidian

    # Media
    vlc

    # Nix Stuff
    fmt # Small, safe and fast formatting library
    nixpkgs-fmt # Nix code formatter for nixpkgs
    dpkg # The Debian package manager
    rpm # The RPM Package Manager
    pacman # A simple library-based package manager

    flatpak # Linux application sandboxing and distribution framework



    # Icons & Themes
    papirus-icon-theme

    # Social
    discord

    # Disks & Partitions
    fuse3
    ntfs3g
    efibootmgr

    # CLI Tools
    lsof
    yt-dlp

    # Hacking & security Tools
    hashcat
    hashcat-utils
    hcxtools

    # Gnome Stuff
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
    pomodoro-gtk
    tomato-c

    # Custom Stuff
    (import ~/nixpkgs/fdm.nix)
  ];

  # hardware.opengl.driSupport32Bit = true;
  # hardware.pulseaudio.support32Bit = true;


  virtualisation.libvirtd.enable = true;

  # xdg.portal = {
  #   enable = true;
  #   config.common.default = "*";
  #   extraPortals = [pkgs.xdg-desktop-portal-gtk];
  # };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable IPv4 forwarding
  #networking.forwardIPv4 = true;

  # Configure the eno1 interface (your router)
  # networking.interfaces.eno1.ipAddress = "10.42.0.1";
  # networking.interfaces.eno1.prefixLength = 24;

  # Configure the wlp0s16f1u2 interface (your Wi-Fi adapter)
  # networking.interfaces.wlp0s16f1u2.useDHCP = true;

  # Configure dnsmasq
  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "eno1"; # Listen on the eno1 interface
      domain-needed = true;
      bogus-priv = true;
      # dhcp-range = "10.42.0.2,10.42.0.254,12h";  # DHCP range
      server = [ "8.8.8.8" "8.8.4.4" ]; # DNS servers
    };
  };

  # Enable the firewall
  networking.firewall.enable = true;
  networking.firewall.extraCommands = ''
    iptables -t nat -A POSTROUTING -o wlp0s16f1u2 -j MASQUERADE
  '';


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";

}
