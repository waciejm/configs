{
  services.tailscale = {
    enable = true;
    interfaceName = "tailscale0";
    openFirewall = true;
  };

  networking.firewall.trustedInterfaces = ["tailscale0"];
}
