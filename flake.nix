{
  description = "My NixOS flake!";

  # ╓────────────────────────────────────────────────────────╖
  # ║ Inputs                                                 ║
  # ╙────────────────────────────────────────────────────────╜
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plugin-onedark.url = "github:navarasu/onedark.nvim"; # OneDark theme plugin for Neovim
    plugin-onedark.flake = false; # This plugin is not a flake
  };

  # ╓────────────────────────────────────────────────────────╖
  # ║ Outputs                                                ║
  # ╙────────────────────────────────────────────────────────╜
  outputs = { self, nixpkgs, ... }@inputs:
    let
      # lib = nixpkgs.lib;
      system = "x86_64-linux";
      # pkgs = import nixpkgs { inherit system; }; # In terms of effect, there might not be much difference between using nixpkgs.legacyPackages.$ {system} and import nixpkgs { inherit system; } apart from import being able to override packages1. However, when it comes to evaluation efficiency and preventing multiple instances of nixpkgs, using nixpkgs.legacyPackages.$ {system} is generally preferred
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
      inherit (self) outputs;
    in
    {

      ## System Configuration
      # replace 'Sharad' with your hostname here.
      nixosConfigurations.Sharad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos/configuration.nix ];
      };

      ## Home-Manager
      # replace 'sharad' with your username here.
      homeConfigurations.sharad = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs pkgs-stable;};  # Pass the inputs to the home-manager configuration
        modules = [ ./home-manager/home.nix ]; # load home.nix from selected PROFILE
      };

    };
  #────────────────────────── END ────────────────────────────
}
