{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.waciejm.graphical {
    services.syoncthing.tray.enable = true;
  };
}
