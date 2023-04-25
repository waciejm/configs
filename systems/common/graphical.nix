{
  platform,
  nixpkgs,
  configs-private,
  ...
}: let
  pkgs = nixpkgs.legacyPackages."${platform}";
  private-fonts = configs-private.waciejm.mkFonts pkgs;
in {
  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

  fonts = {
    fonts = [
      private-fonts.comic-code
    ];
    fontconfig = {
      subpixel.rgba = "none";
      defaultFonts.monospace = ["ComicCodeLigatures Nerd Font"];
    };
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  services = {
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

  environment.systemPackages = [
    pkgs.mako
    pkgs.eww-wayland
    pkgs.wofi
    pkgs.swww
    pkgs.swaylock-effects
    pkgs.pavucontrol

    pkgs.firefox
  ];

  security = {
    rtkit.enable = true;
    pam.services.swaylock = {}; 
  };
}
