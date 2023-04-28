{
  pkgs,
  configs-private,
  ...
}: let
  private-fonts = configs-private.waciejm.mkFonts pkgs;
  random-wallpaper = (configs-private.waciejm.mkWallpapers pkgs).random-wallpaper;
in {
  environment.systemPackages =
    [
      pkgs.mako
      pkgs.eww-wayland
      pkgs.wofi
      pkgs.swww
      pkgs.swaylock
      pkgs.pavucontrol
      random-wallpaper
    ]
    ++ builtins.attrValues {
      inherit
        (pkgs)
        alacritty
        audacity
        chatterino2
        discord
        feh
        firefox
        gimp
        handbrake
        kdenlive
        keepassxc
        mpv
        nextcloud-client
        openscad
        prusa-slicer
        psst
        signal-desktop
        slack
        streamlink
        thunderbird
        ungoogled-chromium
        vscode-fhs
        ;
    };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  services = {
    xserver = {
      layout = "pl";
      xkbVariant = "";
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
    fonts = [
      private-fonts.comic-code
    ];
    fontconfig.defaultFonts.monospace = ["ComicCodeLigatures Nerd Font"];
  };

  security = {
    rtkit.enable = true;
    pam.services.swaylock = {};
  };
}
