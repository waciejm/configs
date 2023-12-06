{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    interfaceName = "tailscale0";
  };
  networking.firewall.trustedInterfaces = ["tailscale0"];
}
