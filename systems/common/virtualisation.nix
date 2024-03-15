{pkgs, ...}: {
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
    virtualbox.host.enable = true;
  };

  environment.systemPackages = [pkgs.dive];

  users.users.waciejm.extraGroups = ["docker" "vboxusers"];
}
