{
  config,
  pkgs,
  ...
}:{
  home.homeDirectory = "/Users/waciejm";

  imports = [
    ../common/home.nix
  ];

  home.file = {
    ".swiftbar".source = ./swiftbar;
  };
}
