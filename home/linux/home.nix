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

  home.file = {
    ".autostart".source = ./autostart;
  };

  xdg.configFile = {
    "hypr".source = config/hypr;
    "swaylock".source = config/swaylock;
    "rofi".source = config/rofi;
    "waybar".source = config/waybar;
  };

  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];

  gtk = {
    enable = true;
    theme.name = "Gruvbox-Dark-BL";
    theme.package = pkgs.gruvbox-gtk-theme;
    iconTheme.name = "gruvbox-dark-gtk";
    iconTheme.package = pkgs.gruvbox-dark-icons-gtk;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-icon-theme-name = "gruvbox-dark-gtk";
    };
  };
}
