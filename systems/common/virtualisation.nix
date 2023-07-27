{...}: {
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  users.users.waciejm.extraGroups = ["docker"];
}
