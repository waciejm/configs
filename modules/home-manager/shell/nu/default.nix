{ config, lib, ... }:
{
  options.custom.shell.nu = {
    enable = lib.mkEnableOption "nushell with custom configuration as user shell";
  };

  config =
    let
      cfg = config.custom.shell.nu;
    in
    lib.mkIf cfg.enable {
      programs.nushell = {
        enable = true;
        configFile.source = ./config.nu;
      };
      home.sessionVariables.SHELL = lib.getExe config.programs.nushell.package;
    };
}
