{pkgs, ...}: {
  virtualisation.docker.enable = true;
  users.users.waciejm.extraGroups = ["docker"];
  environment.systemPackages = [pkgs.dive];
}
