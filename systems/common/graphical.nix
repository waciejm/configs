{...}: {
  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };
  };
}
