{
  self,
  nixpkgs,
  home-manager,
  disko,
  lanzaboote,
  configs-private,
  nixos-hardware,
  nixos-cosmic,
  sops-nix,
  arion,
  ...
}: let
  mkSystem = {
    hostname,
    system,
    extraModules,
  }:
    nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit
          self
          system
          hostname
          nixpkgs
          home-manager
          configs-private
          nixos-hardware
          ;
        selfPkgs = self.packages."${system}";
      };
      modules =
        [
          ./${hostname}/configuration.nix
          ./common/configuration.nix
          disko.nixosModules.disko
          lanzaboote.nixosModules.lanzaboote
          nixos-cosmic.nixosModules.default
          sops-nix.nixosModules.sops
          arion.nixosModules.arion
        ]
        ++ extraModules;
    };
in {
  ferra = mkSystem {
    hostname = "ferra";
    system = "x86_64-linux";
    extraModules = [
      ./common/secureboot.nix
      ./common/sshd.nix
      ./common/tailscale.nix
      ./common/syncthing.nix
      ./common/graphical.nix
      ./common/bluetooth.nix
      ./common/containerisation.nix
      ./common/android.nix
      ./common/embedded.nix
      ./common/scanning.nix
      ./common/gaming.nix
      ./common/cosmic.nix
      ./common/nix-ld.nix
    ];
  };
  frork = mkSystem {
    hostname = "frork";
    system = "x86_64-linux";
    extraModules = [
      ./common/laptop.nix
      ./common/wifi.nix
      ./common/secureboot.nix
      ./common/sshd.nix
      ./common/tailscale.nix
      ./common/syncthing.nix
      ./common/graphical.nix
      ./common/bluetooth.nix
      ./common/containerisation.nix
      ./common/android.nix
      ./common/embedded.nix
      ./common/scanning.nix
      ./common/gaming.nix
      ./common/cosmic.nix
      ./common/nix-ld.nix
    ];
  };
  bolek = mkSystem {
    hostname = "bolek";
    system = "x86_64-linux";
    extraModules = [];
  };
}
