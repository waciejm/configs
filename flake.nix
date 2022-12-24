{
  description = "Home Manager configuration for waciejm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: {
    packages.x86_64-linux.home-manager = home-manager.packages.x86_64-linux.home-manager;
    packages.aarch64-darwin.home-manager = home-manager.packages.aarch64-darwin.home-manager;
  
    homeConfigurations.waciejm-macos = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      modules = [ ./home/macos/home.nix ];
    };

    homeConfigurations.waciejm-linux = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./home/linux/home.nix ];
    };
  };
}
