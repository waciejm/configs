{
  imports = [
    ../common/home.nix
  ];

  home.homeDirectory = "/Users/waciejm";

  home.file = {
    ".swiftbar".source = ./swiftbar;
  };
}
