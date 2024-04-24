{
  pkgs,
  mkShell,
  poetry,
  ...
}: let
  shells = [
    {
      suffix = "";
      version = "312";
    }
    {
      suffix = "312";
      version = "312";
    }
    {
      suffix = "311";
      version = "311";
    }
    {
      suffix = "310";
      version = "310";
    }
    {
      suffix = "39";
      version = "39";
    }
  ];
in
  builtins.map ({
    suffix,
    version,
  }: {
    name = "shell-python${suffix}";
    value = mkShell {
      packages = [
        pkgs."python${version}"
        poetry
      ];
    };
  })
  shells
