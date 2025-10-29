{
  projectRootFile = "flake.nix";
  settings.on-unmatched = "info";
  programs = {
    # keep-sorted start block=yes
    keep-sorted.enable = true;
    nixfmt.enable = true;
    # keep-sorted end
  };
}
