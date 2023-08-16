{
  nixpkgs,
  nixpkgs-stable,
  home-manager,
  configs-private,
  ...
}: {
  badura = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit nixpkgs;
      inherit home-manager;
      inherit configs-private;
      pkgs-stable = nixpkgs-stable.legacyPackages.x86_64-linux;
    };
    modules = [
      ./badura/configuration.nix
      ./common/configuration.nix
      ./common/android.nix
      ./common/graphical.nix
      ./common/tailscale.nix
      ./common/virtualisation.nix
      ./common/bluetooth.nix
      ./common/dev-networking.nix
      ./common/gaming.nix
    ];
  };
  cigma = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit nixpkgs;
      inherit home-manager;
      inherit configs-private;
      pkgs-stable = nixpkgs-stable.legacyPackages.x86_64-linux;
    };
    modules = [
      ./cigma/configuration.nix
      ./common/configuration.nix
      ./common/android.nix
      ./common/graphical.nix
      ./common/tailscale.nix
      ./common/virtualisation.nix
      ./common/bluetooth.nix
    ];
  };
}
