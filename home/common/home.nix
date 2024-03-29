{
  self,
  pkgs,
  lib,
  nixpkgs,
  config,
  ...
}: let
  mkLink = target:
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/${target}";
in {
  options = {
    waciejm.graphical = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = {
    programs.home-manager.enable = true;

    home.username = "waciejm";

    home.stateVersion = "22.11";

    home.packages = builtins.attrValues {
      inherit
        (pkgs)
        age
        alejandra
        amber
        bat
        du-dust
        fd
        ffmpeg
        git-review
        gitui
        gzip
        helix
        htop
        imagemagick
        jless
        just
        lsd
        mdcat
        ncspot
        neovim
        nil
        nix-zsh-completions
        nushell
        ripgrep
        rm-improved
        rsync
        sops
        starship
        taplo
        tree
        unzip
        wally-cli
        yt-dlp
        zellij
        zip
        zoxide
        zsh-completions
        ;
    };

    home.file = {
      # zsh
      ".zshrc".source = ./zshrc;
      ".zshenv".source = ./zshenv;
      ".zfunc".source = ./zfunc;
      # ssh
      ".ssh" = {
        source = ./ssh;
        recursive = true;
      };
      ".ssh/ssh_waciejm".source = mkLink "Keys/ssh_waciejm";
      ".ssh/ssh_waciejm.pub".source = mkLink "Keys/ssh_waciejm.pub";
      ".ssh/ssh_mac1".source = mkLink "Keys/ssh_mac1";
      ".ssh/ssh_mac1.pub".source = mkLink "Keys/ssh_mac1.pub";
    };

    xdg.configFile = {
      "nix" = {
        source = ./config/nix;
        recursive = true;
      };
      "git".source = ./config/git;
      "starship.toml".source = ./config/starship.toml;
      "alacritty".source = ./config/alacritty;
      "helix".source = ./config/helix;
    };

    nix.registry = {
      nixpkgs = {
        from = {
          type = "indirect";
          id = "n";
        };
        flake = nixpkgs;
      };
      config = {
        from = {
          type = "indirect";
          id = "c";
        };
        flake = self;
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
