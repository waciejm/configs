{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      age
      alejandra
      amber
      bat
      cyme
      du-dust
      fd
      ffmpeg
      git-review
      gitui
      gzip
      htop
      imagemagick
      jless
      joshuto
      just
      lsd
      mdcat
      ncspot
      neovim
      nil
      ripgrep
      rm-improved
      rsync
      sops
      taplo
      tree
      unzip
      wally-cli
      yt-dlp
      zip
      ;
  };
}
