{
  nixpkgs,
  home-manager,
  configs-private,
  ...
}: {
  badura = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      nixpkgs-flake = nixpkgs;
      inherit home-manager;
      inherit configs-private;
    };
    modules = [
      ./badura/configuration.nix
      ./common/configuration.nix
      ./common/android.nix
      ./common/graphical.nix
      ./common/tailscale.nix
      ./common/virtualisation.nix
      ./common/gaming.nix
      ./common/mullvad.nix
    ];
  };
  cigma = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      nixpkgs-flake = nixpkgs;
      inherit home-manager;
      inherit configs-private;
    };
    modules = [
      ./cigma/configuration.nix
      ./common/configuration.nix
      ./common/android.nix
      ./common/graphical.nix
      ./common/tailscale.nix
      ./common/virtualisation.nix
    ];
  };
}
