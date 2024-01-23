{
  writeShellApplication,
  cargo-watch,
  ...
}:
writeShellApplication {
  name = "clippy-watch";
  runtimeInputs = [cargo-watch];
  text = ''
    cargo watch -q -s "clear; cargo clippy --all-targets"
  '';
}
