{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.android-studio
  ];

  # programs.adb.enable = true;

  users.users.waciejm.extraGroups = ["adbusers"];
}
