{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    extraUpFlags = ["--ssh"];
    interfaceName = "tailscale0";
  };
  networking.firewall.trustedInterfaces = ["tailscale0"];
}
