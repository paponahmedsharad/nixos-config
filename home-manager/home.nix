{ config, pkgs, ... }:

{
  home.username = "sharad";
  home.homeDirectory = "/home/sharad";
  home.stateVersion = "23.05"; # This value determines the Home Manager release that your configuration is compatible with. This helps avoid breakage when a new Home Manager release introduces backwards incompatible changes. You should not change this value, even if you update Home Manager. If you do want to update the value, then make sure to first check the Home Manager release notes.
  nixpkgs.config.allowUnfree = true;


  # ╓──────────────────────────────────────────────────────────────────────────────╖
  # ║                                P A C K A G E                                 ║
  # ╙──────────────────────────────────────────────────────────────────────────────╜
  home.packages = with pkgs; [
    ## Command line application
    neovim                    # Text Editor
    htop-vim                  # htop with vim keybind
    btop                      # A monitor of resources
    bat                       # fancy alternative for cat command
    fd                        # a program to find entries in filesystem
    starship                  # Prompt for fish/bash/zsh
    eza                       # "ls" alternative
    lsd                       # "ls" alternative
    unzip                     # unzip zip files
    trash-cli                 # Put files in trash
    fzf                       # fuzzy finder
    ripgrep                   # Silver Searcher with the raw speed of grep
    diff-so-fancy             # fancy diffs ( for git )
    lazygit                   # Git helper
    fuzzel                    # Application launcher
    tofi                      # Application launcher
    # rofi                      # Application launcher
    rofi-wayland              # rofi for wayland
    wofi                      # Application launcher
    blueman                   # Blueman is a GTK+ Bluetooth Manager
    hyprpicker                # color-picker
    feh                       # A fast and light image viewer
    zathura                   # Ebook reader
    mupdf                     # Ebook reader
    wget                      # A utility for non-interactive download
    swaybg                    # Wallpaper tool for Wayland compositors
    hyprpaper                 # Wayland wallpaper utility
    swaynotificationcenter    # Notification daemon and the control center
    nodePackages.browser-sync # Live css reload and browser-syncing
    appimage-run              # appimage-launcher
    grimblast                 # A helper for screenshots within Hyprland
    wezterm                   # Terminal
    nitch                     # system fetch
    neofetch                  # system fetch
    # git                     # version control system

    ## Graphical application
    vlc                       # Video player
    libreoffice-fresh         # Office application
    neovide                   # graphical user interface for Neovim
    pcmanfm                   # file-manager
    gimp                      # Photo Editor
    opera                     # browser
    microsoft-edge-dev        # browser
    whitesur-cursors          # An x-cursor theme
    capitaine-cursors         # cursor
    tela-circle-icon-theme    # Icon
    beauty-line-icon-theme    # Icon
    iwgtk                     # Lightweight, graphical wifi management utility
    scrcpy                    # connect phone
    qt5ct                     # Qt5 Configuration Tool
    wezterm                   # Terminal
    # networkmanagerapplet

    ## rust/dependencies
    rustc                     # A safe, concurrent, practical language
    cargo                     # Download Rust project's dependencies and builds project
    # rust-analyzer           # compiler frontend for the Rust language
    # rustfmt                 # A tool for formatting Rust code
    # clippy                  # A collection of lints to catch common mistakes

    jdk
    luajit                    # High-performance JIT compiler for Lua (for neovim)
    typescript                # A superset of JavaScript that compiles to clean JavaScript output
    bun                       # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
    nodejs_20                 # Event-driven I/O framework for the V8 JavaScript engine
    # Neovim utility
    stylua                    # code formatter
    lua-language-server       #lsp

    # Fonts
    # (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];


  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };

  services.udiskie.enable = true;

  # ╓──────────────────────────────────────────────────────────────────────────────╖
  # ║                                 C O N F I G                                  ║
  # ╙──────────────────────────────────────────────────────────────────────────────╜
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    # package = pkgs.whitesur-cursors;
    # name = "WhiteSur Cursors";
    size = 16;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    font = {
      # package = (pkgs.nerdfonts.override { fonts = [ "Mononoki" ]; });
      name = "SF Pro Display Regular";
      size = 10;
    };
    iconTheme = {
      package = (pkgs.catppuccin-papirus-folders.override { flavor = "mocha"; accent = "peach"; });
      # name  = "Papirus-Dark";
      name = "Tela-circle";
    };
    theme = {
      package = (pkgs.catppuccin-gtk.override { accents = [ "peach" ]; size = "standard"; variant = "mocha"; });
      name = "Catppuccin-Mocha-Standard-Peach-Dark";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage{{{
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sharad/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    git = {
      enable = true;
      userName = "sharad";
      userEmail = "phs#gmail.com";
      extraConfig = {
        core = {
          editor = "nvim";
          pager = "diff-so-fancy | bat";
        };
      };
    };
  };

  programs.fish.shellAbbrs = {
    nixp = "nix-shell -p";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
#}}}
