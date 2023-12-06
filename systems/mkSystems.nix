{
  nixpkgs,
  home-manager,
  disko,
  configs-private,
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
        inherit system;
        inherit hostname;
        inherit nixpkgs;
        inherit home-manager;
        inherit configs-private;
      };
      modules =
        [
          ./${hostname}/configuration.nix
          ./common/configuration.nix
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
      ./common/gaming.nix
      ./common/scanning.nix
    ];
  };
  boxy = mkSystem {
    hostname = "boxy";
    system = "x86_64-linux";
    extraModules = [
      disko.nixosModules.disko
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
    ];
  };
}
