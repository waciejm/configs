{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.graphical.theming = {
    enable = lib.mkEnableOption "GUI theming stuff";
  };

  config =
    let
      cfg = config.custom.graphical.theming;
    in
    lib.mkIf cfg.enable {
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
    };
}
