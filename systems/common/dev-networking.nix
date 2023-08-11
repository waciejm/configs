{
  networking.firewall = {
    allowedUDPPortRanges = [{
      from = 8000;
      to = 8099;
    }];
    allowedTCPPortRanges = [{
      from = 8000;
      to = 8099;
    }];
  };
}
