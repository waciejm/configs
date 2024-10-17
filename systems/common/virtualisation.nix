{pkgs, ...}: {
  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
    };
  };

  users.users.waciejm.extraGroups = [
    "docker"
    "vboxusers"
  ];

  environment.systemPackages = [
    pkgs.dive
  ];
}
