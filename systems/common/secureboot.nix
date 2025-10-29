{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = [
    pkgs.sbctl # secure boot
    pkgs.tpm2-tss # required for unlocking LUKS devices with TPM2
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
