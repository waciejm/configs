{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.capabilities.secureboot = {
    enable = lib.mkEnableOption "secureboot configuration";
  };

  config =
    let
      cfg = config.custom.capabilities.secureboot;
    in
    lib.mkIf cfg.enable {

      environment.systemPackages = [
        pkgs.sbctl # secure boot
        pkgs.tpm2-tss # required for unlocking LUKS devices with TPM2
      ];

      boot.loader.systemd-boot.enable = false;

      boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };
}
