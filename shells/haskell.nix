{
  pkgs,
  mkShell,
  ...
}: [
  {
    name = "shell-haskell";
    value = mkShell {
      packages = [
        (pkgs.haskellPackages.ghcWithPackages (pkgs: [pkgs.cabal-install]))
        pkgs.haskell-language-server
      ];
    };
  }
]
