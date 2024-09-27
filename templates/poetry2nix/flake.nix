{
  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      poetry2nix = import inputs.poetry2nix {inherit pkgs;};
    in {
      devShells.default =
        (poetry2nix.mkPoetryEnv {
          projectDir = ./.;
          python = pkgs.python3;
          preferWheels = true;
        })
        .env;
    });
}
