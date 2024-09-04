{
  fenixPkgs,
  selfPkgs,
  pkgs,
  mkShell,
  ...
}: let
  shells = [
    {
      suffix = "";
      toolchain = "stable";
    }
  ];
in
  builtins.map ({
    suffix,
    toolchain,
  }: {
    name = "shell-macroquad${suffix}";
    value = mkShell {
      packages = [
        fenixPkgs."${toolchain}".toolchain
        selfPkgs.clippy-watch
        pkgs.rust-analyzer
      ];
      nativeBuildInputs = [
        pkgs.rustPlatform.bindgenHook
        pkgs.pkg-config
        pkgs.cmake
      ];
      buildInputs = [
        pkgs.alsa-lib.dev
      ];
      LD_LIBRARY_PATH = builtins.concatStringsSep ":" [
        "${pkgs.xorg.libX11}/lib"
        "${pkgs.xorg.libXi}/lib"
        "${pkgs.libGL}/lib"
        "${pkgs.libxkbcommon}/lib"
      ];
    };
  })
  shells
