{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.capabilities.gaming = {
    enable = lib.mkEnableOption "GAMING!";
  };

  config =
    let
      cfg = config.custom.capabilities.gaming;
    in
    lib.mkIf cfg.enable {

      programs.steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      environment.systemPackages = [
        pkgs.prismlauncher
      ];
    };
}
