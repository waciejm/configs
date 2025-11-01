{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.capabilities.gaming = {
    enable = lib.mkEnableOption "GAMING!";
    steam = lib.mkEnableOption "Steam";
    minecraft = lib.mkEnableOption "Minecraft";
  };

  config =
    let
      cfg = config.custom.capabilities.gaming;
    in
    lib.mkIf cfg.enable {

      programs.steam = lib.mkIf cfg.steam {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      environment.systemPackages = lib.mkIf cfg.minecraft [
        pkgs.prismlauncher
      ];
    };
}
