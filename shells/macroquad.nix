{
  fenixPkgs,
  pkgs,
  mkShell,
  ...
}: [
  {
    name = "shell-macroquad";
    value = mkShell {
      packages = [
        fenixPkgs.stable.toolchain
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
  }
]
