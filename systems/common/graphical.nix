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

  fonts.fonts = private-fonts;

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };
  };
}
