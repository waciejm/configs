{
  config,
  pkgs,
  ...
}: {
  programs.home-manager.enable = true;

  home.username = "waciejm";

  home.stateVersion = "22.11";

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      age
      bat
      fd
      ffmpeg
      git-review
      gitui
      helix
      jless
      lsd
      nil
      nix-zsh-completions
      nushell
      poetry
      ripgrep
      rsync
      rust-analyzer
      rustup
      sops
      starship
      taplo
      tree
      yt-dlp
      zellij
      zoxide
      zsh-completions
      ;
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
    "nix".source = ./config/nix;
    "git".source = ./config/git;
    "starship.toml".source = ./config/starship.toml;
    "alacritty".source = ./config/alacritty;
  };
}
