{
  fenixPkgs,
  selfPkgs,
  mkShell,
  ...
}: let
  shells = [
    {
      suffix = "Stable";
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
        fenixPkgs.rust-analyzer
        selfPkgs.clippy-watch
      ];
    };
  })
  shells
