{
  config,
  pkgs,
  lib,
  nixpkgs,
  ...
}: let
  mkLink = target: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${target}";
in {
  options = {
    waciejm.graphical = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    waciejm.linkSyncthing = lib.mkOption {
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
        poetry
        python39
        python311
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
      python310 = lib.hiPrio pkgs.python310;
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

    nix.registry.nixpkgs = {
      from = {
        type = "indirect";
        id = "nixpkgs";
      };
      flake = nixpkgs;
    };

    nixpkgs.config.allowUnfree = true;
  };
}
