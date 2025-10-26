{ lib, config, ...}: {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    environmentVariables = {
      NIX_USER_CONF_FILES = lib.concatStringsSep ":" [
        (config.xdg.configHome + "/nix/nix.conf")
        (config.home.homeDirectory + "/Keys/nix-github-access.conf")
      ];
    };
  };
}
