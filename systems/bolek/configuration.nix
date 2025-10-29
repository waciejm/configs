{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./assertions.nix
    ./boot.nix
    ./disks.nix
    ./sshd.nix
    ./tailscale.nix
    ./caddy.nix
    ./syncthing.nix
    ./ydls.nix
  ];

  system.stateVersion = "24.05";

  sops = {
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    gnupg.sshKeyPaths = [ ];
  };

  networking.domain = "rat-interval.ts.net";

  security.sudo.wheelNeedsPassword = false;

  hardware.cpu.amd.updateMicrocode = true;
}
