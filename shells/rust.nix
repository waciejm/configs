{
  fenixPkgs,
  selfPkgs,
  mkShell,
  ...
}: let
  shells = [
    {
      suffix = "";
      toolchain = "stable";
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
        fenixPkgs.rust-analyzer
        selfPkgs.clippy-watch
      ];
    };
  })
  shells

