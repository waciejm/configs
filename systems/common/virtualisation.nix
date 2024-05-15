{pkgs, ...}: {
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      # dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  users.users.waciejm.extraGroups = ["docker"];

  environment.systemPackages = [
    pkgs.dive
    pkgs.podman-tui
    pkgs.podman-compose
  ];
}
