{pkgs, ...}: let 
  tailscale-restart = pkgs.writeShellApplication {
    name = "tailscale-restart";
    runtimeInputs = [pkgs.tailscale];
    text = "tailscale down && tailscale up";
    };
in {
  services.tailscale = {
    enable = true;
    openFirewall = true;
    interfaceName = "tailscale0";
  };

  networking.firewall.trustedInterfaces = ["tailscale0"];

  systemd.services.tailscale-restart = {
    description = "Restart tailscale after suspend";
    wantedBy = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
      "suspend-then-hibernate.target"
    ];
    after = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
      "suspend-then-hibernate.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 20";
      ExecStart = "${tailscale-restart}/bin/tailscale-restart";
    };
  };
}
