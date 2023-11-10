{
  description = "My NixOS flake!";

  # ╓────────────────────────────────────────────────────────╖
  # ║ Inputs                                                 ║
  # ╙────────────────────────────────────────────────────────╜
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # ╓────────────────────────────────────────────────────────╖
  # ║ Outputs                                                ║
  # ╙────────────────────────────────────────────────────────╜
  outputs = { self, nixpkgs, home-manager }:
    let
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {

      ## System Configuration
      # replace 'Sharad' with your hostname here.
      nixosConfigurations.Sharad = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos/configuration.nix ];
      };

      ## Home-Manager
      # replace 'sharad' with your username here.
      homeConfigurations.sharad = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-manager/home.nix ]; # load home.nix from selected PROFILE
      };

    };
  #────────────────────────── END ────────────────────────────
}
