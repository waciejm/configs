{pkgs, ...}: {
  imports = [
    ../common/home.nix
  ];

  home.homeDirectory = "/home/waciejm";

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      git
      ;
  };

  xdg.configFile = {
    "hypr".source = config/hypr;
    "swaylock".source = config/swaylock;
    "wofi".source = config/wofi;
    "waybar".source = config/waybar;
  };

  gtk = {
    enable = true;
    iconTheme.name = "Arc";
    iconTheme.package = pkgs.arc-icon-theme;
    theme.name = "Arc-Dark";
    theme.package = pkgs.arc-theme;
  };
}
