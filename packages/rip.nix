{
  writeShellApplication,
  rm-improved,
  ...
}:
writeShellApplication {
  name = "rip";
  runtimeInputs = [rm-improved];
  text = ''
    rip --graveyard ~/.graveyard "$@"
  '';
}
