{pkgs, ...}: {
  hardware.bluetooth.enable = true;
  environment.systemPackages = [pkgs.bluetuith];
}
