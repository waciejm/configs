{
  nixpkgs-unstable,
  home-manager,
  configs-private,
  ...
}: {
  badura = nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      nixpkgs-flake = nixpkgs-unstable;
      inherit home-manager;
      inherit configs-private;
    };
    modules = [
      ./badura/configuration.nix
      ./common/configuration.nix
      ./common/android.nix
      ./common/graphical.nix
      ./common/gaming.nix
      ./common/tailscale.nix
      ./common/virtualisation.nix
    ];
  };
}
