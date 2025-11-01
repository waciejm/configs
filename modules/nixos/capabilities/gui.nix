{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.capabilities.gui = {
    enable = lib.mkEnableOption "Cosmic DE and other GUI settings";
  };

  config =
    let
      cfg = config.custom.capabilities.gui;
    in
    lib.mkIf cfg.enable {

      services = {
        desktopManager.cosmic.enable = true;
        displayManager.cosmic-greeter.enable = true;
        xserver.xkb = {
          layout = "pl";
          variant = "";
        };
        pipewire = {
          enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          pulse.enable = true;
          wireplumber.enable = true;
        };
      };

      fonts = {
        packages = [ pkgs.nerd-fonts.iosevka-term ];
        fontconfig.defaultFonts.monospace = [ "IosevkaTerm Nerd Font" ];
      };

      programs.dconf.enable = true;

      security.rtkit.enable = true;

      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      '';

      environment.systemPackages =
        builtins.attrValues {
          inherit (pkgs)
            audacity
            blender
            discord
            feh
            firefox
            gimp3
            google-chrome
            gsettings-qt
            gsettings-desktop-schemas
            gthumb
            gtk-engine-murrine
            keepassxc
            libreoffice
            # openscad-unstable
            prusa-slicer
            signal-desktop
            ;
        }
        ++ [
          pkgs.qt6.qtwayland
          pkgs.libsForQt5.qt5.qtwayland
        ];
    };
}
