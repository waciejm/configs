{
  description = "Home and systems configurations for waciejm";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixpkgs-nixos,
    home-manager,
    ...
  }: {
    packages = {
      aarch64-darwin.home-manager = home-manager.packages.aarch64-darwin.home-manager;
      x86_64-darwin.home-manager = home-manager.packages.x86_64-darwin.home-manager;
      aarch64-linux.home-manager = home-manager.packages.aarch64-linux.home-manager;
      x86_64-linux.home-manager = home-manager.packages.x86_64-linux.home-manager;
    };

    homeConfigurations = {
      waciejm-macos-aarch64 = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.aarch64-darwin;
        modules = [./home/macos/home.nix];
      };
      waciejm-macos-x86_64 = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-darwin;
        modules = [./home/macos/home.nix];
      };
      waciejm-linux-aarch64 = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.aarch64-linux;
        modules = [./home/linux/home.nix];
      };
      waciejm-linux-x86_64 = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
        modules = [./home/linux/home.nix];
      };
    };

    nixosConfigurations = {
      badura = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./systems/badura/configuration.nix
          {_module.args.flakeInputs.nixpkgs = nixpkgs-unstable;}
        ];
      };
      nixos-vm = nixpkgs-nixos.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./systems/nixos-vm/configuration.nix
          {_module.args.flakeInputs.nixpkgs = nixpkgs-nixos;}
        ];
      };
    };
  };
}
