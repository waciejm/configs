{
  self,
  nixpkgs,
  home-manager,
  disko,
  lanzaboote,
  configs-private,
  nixos-hardware,
  nixos-cosmic,
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
        ]
        ++ extraModules;
    };
in {
  badura = mkSystem {
    hostname = "badura";
    system = "x86_64-linux";
    extraModules = [
      ./common/sshd.nix
      ./common/tailscale.nix
      ./common/syncthing.nix
      ./common/graphical.nix
      ./common/bluetooth.nix
      ./common/virtualisation.nix
      ./common/android.nix
      ./common/dev-networking.nix
      ./common/embedded.nix
      ./common/scanning.nix
      ./common/gaming.nix
    ];
  };
  boxy = mkSystem {
    hostname = "boxy";
    system = "x86_64-linux";
    extraModules = [
      ./common/secureboot.nix
      ./common/wifi.nix
      ./common/sshd.nix
      ./common/tailscale.nix
      ./common/syncthing.nix
      ./common/graphical.nix
      ./common/bluetooth.nix
      ./common/virtualisation.nix
      ./common/android.nix
      ./common/dev-networking.nix
      ./common/embedded.nix
      ./common/gaming.nix
    ];
  };
  frork = mkSystem {
    hostname = "frork";
    system = "x86_64-linux";
    extraModules = [
      ./common/laptop.nix
      ./common/secureboot.nix
      ./common/wifi.nix
      ./common/sshd.nix
      ./common/tailscale.nix
      ./common/syncthing.nix
      ./common/graphical.nix
      ./common/bluetooth.nix
      ./common/virtualisation.nix
      ./common/android.nix
      ./common/dev-networking.nix
      ./common/embedded.nix
      ./common/gaming.nix
      ./common/cosmic.nix
    ];
  };
}
