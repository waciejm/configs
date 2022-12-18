{
  config,
  pkgs,
  ...
}:{
  home.homeDirectory = "/home/waciejm";

  imports = [
    ../common/home.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      git
    ;
  };
}
