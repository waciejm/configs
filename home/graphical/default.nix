{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hypr.nix
    ./waybar.nix
    ./alacritty.nix
  ];

  config = lib.mkIf config.waciejm.graphical {
    home.file.".icons".source = ./icons;

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

    programs.rofi = lib.mkIf config.waciejm.graphical {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "gruvbox-dark";
      extraConfig = {
        show-icons = true;
      };
    };

    services.easyeffects = {
      enable = true;
      preset = "";
    };
  };
}
