{pkgs, ...}: {
  home-manager.sharedModules = [{waciejm.graphical = true;}];

  environment.systemPackages =
    builtins.attrValues {
      inherit
        (pkgs)
        alacritty
        audacity
        blender
        brightnessctl
        chatterino2
        discord
        easyeffects
        feh
        firefox
        gimp
        godot_4
        google-chrome
        grim
        gsettings-qt
        gsettings-desktop-schemas
        gthumb
        gtk-engine-murrine
        handbrake
        kdenlive
        keepassxc
        libreoffice
        mako
        mpv
        obsidian
        openscad
        okular
        pamixer
        pavucontrol
        playerctl
        prusa-slicer
        pulsemixer
        rofi-wayland
        signal-desktop
        slack
        slurp
        swaybg
        swaylock
        thunderbird
        vscode-fhs
        waybar
        webcord
        wf-recorder
        wl-clipboard
        ;
    }
    ++ [
      pkgs.xfce.thunar
      pkgs.qt6.qtwayland
      pkgs.libsForQt5.qt5.qtwayland
    ];

  # remove after obsidian updates electron
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    dconf.enable = true;
  };

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
    flatpak.enable = true;
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
    pam.services = {
      swaylock = {};
    };
  };

  gtk.iconCache.enable = true;

  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "gnome";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "xcb";
  };
}
