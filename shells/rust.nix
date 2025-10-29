{
  fenixPkgs,
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
    name = "shell-rust${suffix}";
    value = mkShell {
      packages = [
        fenixPkgs."${toolchain}".toolchain
        pkgs.cargo-watch
        pkgs.rust-analyzer
      ];
    };
  })
  shells
