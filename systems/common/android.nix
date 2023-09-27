{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.android-studio
  ];

  programs.adb.enable = true;
  users.users.waciejm.extraGroups = ["adbusers"];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="1782", ATTR{idProduct}=="4003", MODE="0666", GROUP="adbusers"
  '';
}
