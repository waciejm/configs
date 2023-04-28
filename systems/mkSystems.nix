{
  nixpkgs-unstable,
  home-manager,
  configs-private,
  ...
}: {
  badura = nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      home-manager = home-manager;
      configs-private = configs-private;
      nixpkgs-flake = nixpkgs-unstable;
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
