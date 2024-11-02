{
  nix.settings = {
    substituters = ["https://cosmic.cachix.org/"];
    trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
  };

  # workaround for direct scanout hanging system with linux 6.11
  environment.sessionVariables.COSMIC_DISABLE_DIRECT_SCANOUT = "1";

  services = {
    desktopManager.cosmic.enable = true;
    # displayManager.cosmic-greeter.enable = true;
  };
}
