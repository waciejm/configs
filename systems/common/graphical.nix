{
  pkgs,
  configs-private,
  ...
}: let
  #private-fonts = configs-private.mkFonts pkgs;
  random-wallpaper = (configs-private.mkWallpapers pkgs).random-wallpaper;
in {
  home-manager.sharedModules = [{waciejm.graphical = true;}];

  environment.systemPackages =
    builtins.attrValues {
      inherit
        (pkgs)
        alacritty
        audacity
        brightnessctl
        chatterino2
        discord
        easyeffects
        feh
        firefox
        gimp
        google-chrome
        grim
        gsettings-qt
        gsettings-desktop-schemas
        gtk-engine-murrine
        handbrake
        kdenlive
        keepassxc
        libreoffice
        mako
        mpv
        nextcloud-client
        obs-studio
        obsidian
        openscad
        okular
        pamixer
        pavucontrol
        pasystray
        playerctl
        prusa-slicer
        rofi-wayland
        signal-desktop
        slack
        slurp
        swaylock
        swww
        syncthingtray
        thunderbird
        vscode-fhs
        waybar
        webcord
        wl-clipboard
        ;
    }
    ++ [
      random-wallpaper
      pkgs.gnome.seahorse
      pkgs.xfce.thunar
      pkgs.qt6.qtwayland
      pkgs.libsForQt5.qt5.qtwayland
    ];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    dconf.enable = true;
  };

  services = {
    xserver = {
      layout = "pl";
      xkbVariant = "";
    };
    gnome = {
      gnome-keyring.enable = true;
      at-spi2-core.enable = true;
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
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland-egl;wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
