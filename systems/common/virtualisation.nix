{...}: {
  virtualisation.docker.enable = true;

  users.users.waciejm.extraGroups = ["docker"];
}
