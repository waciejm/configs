{ config, lib, pkgs, ...}: {
  options.custom.terminal.rip = {
    enable = lib.mkEnableOption "rm-improved with custom configuration";
  };

  config = let
    cfg = config.custom.terminal.rip;
  in lib.mkIf cfg.enable {
    home.packages = [pkgs.rm-improved];
    home.sessionVariables.GRAVEYARD = "${config.home.homeDirectory}/.graveyard";
  };
}
