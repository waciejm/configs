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
  
  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];

  gtk = {
    enable = true;
    theme.name = "Dracula";
    theme.package = pkgs.dracula-theme;
    iconTheme.name = "Papirus-Dark-Maia";
    iconTheme.package = pkgs.papirus-maia-icon-theme;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-icon-theme-name = "Papirus-Dark-Maia";
    };
  };
}
