{
  pkgs,
  configs-private,
  ...
}: let
  private-fonts = configs-private.waciejm.mkFonts pkgs;
  random-wallpaper = (configs-private.waciejm.mkWallpapers pkgs).random-wallpaper;
in {
  environment.systemPackages = builtins.attrValues {
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
      obsidian
      openscad
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
      thunderbird
      vscode-fhs
      wl-clipboard
      zathura
      ;
    inherit random-wallpaper;
    inherit (pkgs.gnome) seahorse;
    inherit (pkgs.xfce) thunar;
    waybar = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };

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
    gvfs.enable = true;
  };

  fonts = {
    packages = [
      private-fonts.comic-code
    ];
    fontconfig.defaultFonts.monospace = ["ComicCodeLigatures Nerd Font"];
  };

  security = {
    rtkit.enable = true;
    pam.services = {
      swaylock = {};
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
