{
  config,
  pkgs,
  ...
}:{
  programs.home-manager.enable = true;

  home.username = "waciejm";

  home.stateVersion = "22.11";

  home.packages = builtins.attrValues {
    inherit (pkgs)
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
      nushell
      ripgrep
      rsync
      rust-analyzer
      rustup
      sops
      starship
      taplo
      yt-dlp
      zellij
      zoxide
    ;
  };

  home.file = {
    ".zshrc".source = ./zshrc;
    ".zshenv".source = ./zshenv;
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
