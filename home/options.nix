{lib, ...}: {
  options = {
    waciejm.graphical = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    waciejm.laptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
}
