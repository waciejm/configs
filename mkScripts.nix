home-manager: let
  utils = import ./utils.nix;
  nixpkgs = home-manager.inputs.nixpkgs;
in
  utils.forEachPlatform (platform: let
    pkgs = nixpkgs.legacyPackages."${platform}";
  in {
    switch-home = pkgs.writeShellApplication {
      name = "home-switch";
      runtimeInputs = [pkgs.coreutils home-manager.packages."${platform}".home-manager];
      text = ''
        export NIX_CONFIG="experimental-features = nix-command flakes"
        home-manager switch --flake ".#waciejm-${platform}"
      '';
    };
  })
