{
  nixpkgs-unstable,
  home-manager,
  configs-private,
  ...
}: {
  badura = nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      nixpkgs = nixpkgs-unstable;
      home-manager = home-manager;
      configs-private = configs-private;
    };
    modules = [
      ./badura/configuration.nix
      ./common/configuration.nix
      ./common/graphical.nix
      ./common/virtualisation.nix
    ];
  };
}
