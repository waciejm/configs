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
      feh
      firefox
      gimp
      google-chrome
      gsettings-qt
      gsettings-desktop-schemas
      handbrake
      kdenlive
      keepassxc
      libreoffice
      mako
      mpv
      nextcloud-client
      openscad
      pamixer
      pavucontrol
      playerctl
      prusa-slicer
      psst
      signal-desktop
      slack
      streamlink
      swaylock
      swww
      thunderbird
      vscode-fhs
      waybar
      wofi
      zathura
      ;
    inherit random-wallpaper;
    inherit (pkgs.gnome) seahorse;
    inherit (pkgs.xfce) thunar;
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
    flatpak.enable = true;
  };

  fonts = {
    fonts = [
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
