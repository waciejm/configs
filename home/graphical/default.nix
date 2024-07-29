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

    qt = {
      enable = true;
      style.name = "adwaita-dark";
      # platformTheme.name = "gnome";
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
      cursorTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-icon-theme-name = "Adwaita";
      };
    };

    programs.rofi = lib.mkIf config.waciejm.graphical {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "purple";
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
