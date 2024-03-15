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
    {
      suffix = "Beta";
      toolchain = "beta";
    }
    {
      suffix = "Nightly";
      toolchain = "default";
    }
  ];
in
  builtins.map ({
    suffix,
    toolchain,
  }: {
    name = "shellRust${suffix}";
    value = mkShell {
      packages = [
        fenixPkgs."${toolchain}".toolchain
        selfPkgs.clippy-watch
        pkgs.rust-analyzer
      ];
    };
  })
  shells
