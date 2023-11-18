{
  config,
  pkgs,
  pkgs-stable,
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
      helix = pkgs-stable.helix;
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
      ".ssh/ssh_waciejm".source = mkLink "Keys/ssh_waciejm";
      ".ssh/ssh_waciejm.pub".source = mkLink "Keys/ssh_waciejm.pub";
      ".ssh/ssh_mac1".source = mkLink "Keys/ssh_mac1";
      ".ssh/ssh_mac1.pub".source = mkLink "Keys/ssh_mac1.pub";
      # syncthing
      "Archive" = lib.mkIf config.waciejm.linkSyncthing {source = mkLink ".st/Archive";};
      "Desktop" = lib.mkIf config.waciejm.linkSyncthing {source = mkLink ".st/Desktop";};
      "Documents" = lib.mkIf config.waciejm.linkSyncthing {source = mkLink ".st/Documents";};
      "Music" = lib.mkIf config.waciejm.linkSyncthing {source = mkLink ".st/Music";};
      "Pictures" = lib.mkIf config.waciejm.linkSyncthing {source = mkLink ".st/Pictures";};
      "Projects" = lib.mkIf config.waciejm.linkSyncthing {source = mkLink ".st/Projects";};
      "Sync" = lib.mkIf config.waciejm.linkSyncthing {source = mkLink ".st/Sync";};
      # syncthing crypt
      "Keys" = lib.mkIf config.waciejm.linkSyncthing {source = mkLink ".stc/Keys";};
      "qed" = lib.mkIf config.waciejm.linkSyncthing {source = mkLink ".stc/qed";};
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
