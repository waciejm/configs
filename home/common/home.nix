{
  pkgs,
  lib,
  nixpkgs-flake,
  ...
}: {
  programs.home-manager.enable = true;

  home.username = "waciejm";

  home.stateVersion = "22.11";

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      age
      alejandra
      bat
      du-dust
      fd
      ffmpeg
      git-review
      gitui
      helix
      htop
      jless
      lsd
      ncspot
      nil
      nix-zsh-completions
      nushell
      poetry
      python39
      python311
      ripgrep
      rm-improved
      rsync
      rust-analyzer
      rustup
      sops
      starship
      taplo
      tree
      wally-cli
      yt-dlp
      zellij
      zoxide
      zsh-completions
      ;
    python310 = lib.hiPrio pkgs.python310;
  };

  home.file = {
    ".zshrc".source = ./zshrc;
    ".zshenv".source = ./zshenv;
    ".zfunc".source = ./zfunc;
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
  };

  nix.registry.nixpkgs = {
    from = {
      type = "indirect";
      id = "nixpkgs";
    };
    flake = nixpkgs-flake;
  };
}
