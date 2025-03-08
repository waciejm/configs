{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./kitty.nix
    ./wezterm.nix
  ];

  config = lib.mkIf config.waciejm.graphical {
    xdg.systemDirs.data = [
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];

    qt = {
      enable = true;
      style.name = "adwaita-dark";
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      cursorTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-icon-theme-name = "Adwaita";
      };
    };

    dconf.settings."org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      color-scheme = "prefer-dark";
    };

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "purple";
      extraConfig = {
        show-icons = true;
      };
    };
  };
}
