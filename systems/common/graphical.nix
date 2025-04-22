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
        google-chrome
        gsettings-qt
        gsettings-desktop-schemas
        gthumb
        gtk-engine-murrine
        keepassxc
        libreoffice
        obsidian
        openscad-unstable
        prusa-slicer
        signal-desktop
        slack
        vscode-fhs
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

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
}
