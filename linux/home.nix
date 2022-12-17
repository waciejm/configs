{
  config,
  pkgs,
  ...
}:{
  home.homeDirectory = "/home/waciejm";

  imports = [
    ../common/home.nix
  ];
}
