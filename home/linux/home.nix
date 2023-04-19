{pkgs, ...}: {
  imports = [
    ../common/home.nix
  ];

  home.homeDirectory = "/home/waciejm";

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      alacritty
      git
      ;
  };

  xdg.configFile = {
    "hypr".source = config/hypr;
  };
}
