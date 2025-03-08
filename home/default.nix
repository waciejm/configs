{
  self,
  nixpkgs,
  pkgs,
  lib,
  config,
  osConfig ? null,
  ...
}: {
  imports = [
    ./git.nix
    ./graphical
    ./helix.nix
    ./jujutsu.nix
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
    sessionVariables = {
      NIX_USER_CONF_FILES = lib.concatStringsSep ":" [
        (config.xdg.configHome + "/nix/nix.conf")
        (config.home.homeDirectory + "/Keys/nix-github-access.conf")
      ];
    };
  };

  programs.home-manager.enable = true;

  nixpkgs.config = lib.mkIf (osConfig == null) {allowUnfree = true;};

  nix = {
    package = lib.mkDefault pkgs.lix;
    checkConfig = false;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
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
