{pkgs, ...}: {
  home-manager.sharedModules = [{waciejm.graphical = true;}];

  environment.systemPackages =
    builtins.attrValues {
      inherit
        (pkgs)
        alacritty
        audacity
        blender
        discord
        feh
        firefox
        gimp
        godot_4
        gsettings-qt
        gsettings-desktop-schemas
        gthumb
        gtk-engine-murrine
        handbrake
        kdenlive
        keepassxc
        libreoffice
        mpv
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
      # chrome rendering issue workaround
      # https://github.com/NixOS/nixpkgs/issues/306010
      (pkgs.google-chrome.override {
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
      })
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
      (pkgs.nerdfonts.override {fonts = ["IosevkaTerm"];})
    ];
    fontconfig = {
      defaultFonts.monospace = ["IosevkaTerm Nerd Font"];
    };
  };

  security = {
    rtkit.enable = true;
    pam.services.hyprlock = {};
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
