{
  pkgs,
  selfPkgs,
  ...
}: {
  home-manager.sharedModules = [{waciejm.graphical = true;}];

  environment.systemPackages =
    builtins.attrValues {
      inherit
        (pkgs)
        audacity
        blender
        discord
        feh
        firefox
        gimp
        godot_4
        google-chrome
        gsettings-qt
        gsettings-desktop-schemas
        gthumb
        gtk-engine-murrine
        handbrake
        keepassxc
        libreoffice
        obsidian
        openscad-unstable
        pamixer
        prusa-slicer
        pulsemixer
        signal-desktop
        slack
        vscode-fhs
        webcord
        ;
    }
    ++ [
      pkgs.qt6.qtwayland
      pkgs.libsForQt5.qt5.qtwayland
      selfPkgs.picocad
    ];

  programs.dconf.enable = true;

  services = {
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
    printing.enable = true;
  };

  fonts = {
    packages = [
      pkgs.nerd-fonts.iosevka-term
    ];
    fontconfig = {
      defaultFonts.monospace = ["IosevkaTerm Nerd Font"];
    };
  };

  security = {
    rtkit.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
