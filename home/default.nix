{
  self,
  nixpkgs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./git.nix
    ./graphical
    ./helix.nix
    ./options.nix
    ./programs.nix
    ./shell.nix
    ./ssh.nix
    ./yazi.nix
  ];

  home = {
    stateVersion = "22.11";
    username = "waciejm";
    homeDirectory = "/home/waciejm";
  };

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = lib.mkDefault pkgs.nix;
    checkConfig = false;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
    extraOptions = ''
      include ../../Keys/nix-github-access.conf
    '';
    registry = {
      nixpkgs = {
        flake = nixpkgs;
        from = {
          id = "n";
          type = "indirect";
        };
      };
      config = {
        flake = self;
        from = {
          id = "c";
          type = "indirect";
        };
      };
    };
  };
}
