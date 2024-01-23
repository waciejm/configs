{
  pkgs,
  mkShell,
  poetry,
  ...
}: let
  shells = [
    "38"
    "39"
    "310"
    "311"
    "312"
  ];
in
  builtins.map (version: {
    name = "shellPython${version}";
    value = mkShell {
      packages = [
        pkgs."python${version}"
        poetry
      ];
    };
  })
  shells
