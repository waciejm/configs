{
  home-manager.sharedModules = [{waciejm.laptop = true;}];

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "suspend-then-hibernate";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=4h
  '';
}
