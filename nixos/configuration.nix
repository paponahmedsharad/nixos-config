{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix                            # Include the results of the hardware scan.
    ];

  # ╓────────────────────────────────────────────────────────────────────╖
  # ║ Options                                                            ║
  # ╙────────────────────────────────────────────────────────────────────╜
  hardware.enableRedistributableFirmware = true;              # Turn on this option if you want to enable all the firmware with a license allowing redistribution.
  nixpkgs.config.allowUnfree = true;                          # Allow unfree packages
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable Flakes and the new command-line tool
  ## Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  ## Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;                             # enable the blueman service, which provides blueman-applet and blueman-manager
  ## networking.wireless.enable = true;                       # Enables wireless support via wpa_supplicant.
  networking.hostName = "Sharad";                              # Define your hostname.
  networking.networkmanager.enable = true;                    # Enable networking
  ## Locale/TimeZone {{{
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  #}}}


  # ╓────────────────────────────────────────────────────────────────────╖
  # ║ Services                                                           ║
  # ╙────────────────────────────────────────────────────────────────────╜
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      libinput.enable = true;                                   # Enable touchpad support (enabled default in most desktopManager).
      displayManager.gdm = { enable = true; wayland = true; };
      # desktopManager.gnome = { enable = true; };
      # desktopManager.xfce = { enable = true; };
    };
    dbus.enable = true;                                         # Simple interprocess messaging system
    gnome.gnome-keyring.enable = true;                          # keyring (store secrets, passwords, keys, certificates and make them available to applications)
    openssh.enable = true;                                      # Enable the OpenSSH daemon.
    printing.enable = true;
    pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        #jack.enable = true;                                   # If you want to use JACK applications, uncomment this
      };
  };
  # Flatpak
  services.flatpak.enable = true;
  ## Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  ## Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sharad = {
    isNormalUser = true;
    description = "Sharad";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
    ];
  };

  ## enable fish shell
  programs.fish.enable = true;

  ##  Programs
  programs = {
    hyprland = { enable = true; };
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
  services.gvfs.enable = true;                                   # Mount, trash, and other functionalities
  services.tumbler.enable = true;                                # Thumbnail support for images


  # ╓────────────────────────────────────────────────────────────────────╖
  # ║ Packages                                                           ║
  # ╙────────────────────────────────────────────────────────────────────╜
  environment.systemPackages = with pkgs; [
  ## Command line utility
  vim                      # Editor
  fzf                      # fuzzy finder
  brightnessctl            # Small tool for linux to adjust screen brightness
  wl-clipboard             # Command-line copy/paste utilities for Wayland
  wl-clipboard-x11         # drop-in replacement for X11 clipboard tools
  bluez                    # BlueZ - Bluetooth protocol stack for Linux
  bluez-alsa               # Bluez 5 Bluetooth Audio ALSA Backend

  ## Terminal
  alacritty                # Lightweight Terminal
  foot                     # Simple and fast terminal for wayland
  kitty                    # A modern, hackable, featureful, OpenGL based terminal emulator

  ## Browser
  firefox-wayland          # Browser

  ## Dependency for other Programs
  gcc                      # The GNU Compiler Collection includes compiler front ends for C, C++ ...
  lua                      # Powerful, fast, lightweight, embeddable scripting language (for neovim)
  libva-utils              # Libva-utils is a collection of tests for VA-API (VIdeo Acceleration API)
  polkit_gnome             # A dbus session bus service that is used to bring up authentication dialogs
  wlr-randr                # An xrandr clone for wlroots compositors
  xdg-utils                # A set of command line tools that assist applications with a variety of desktop integration tasks
  hyprland-protocols       # bridge the gap between hyprland and and kde/gnome
  qt5.qtwayland
  qt6.qmake
  qt6.qtwayland            # A cross-platform application framework for C++
  ];


  # ╓────────────────────────────────────────────────────────────────────╖
  # ║ Fonts                                                              ║
  # ╙────────────────────────────────────────────────────────────────────╜
  fonts. packages = with pkgs; [
    comic-mono
    (nerdfonts. override { fonts = [ "ComicShannsMono" "CodeNewRoman" "VictorMono" "Noto" ]; })
  ];


  ## Needed services
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      # xdg-desktop-portal
    ];
  };


  # ╓────────────────────────────────────────────────────────────────────╖
  # ║ The End                                                            ║
  # ╙────────────────────────────────────────────────────────────────────╜
  system.stateVersion = "23.05"; # Don't touch it
}
