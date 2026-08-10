{
  fenixPkgs,
  pkgs,
  mkShell,
  ...
}:
[
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
        "${pkgs.libx11}/lib"
        "${pkgs.libxi}/lib"
        "${pkgs.libGL}/lib"
        "${pkgs.libxkbcommon}/lib"
      ];
    };
  }
]
