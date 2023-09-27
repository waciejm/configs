{pkgs, ...}: {
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  environment.systemPackages = [pkgs.dive];

  users.users.waciejm.extraGroups = ["docker"];
}
