{
  writeShellApplication,
  mpv,
  ...
}:
writeShellApplication {
  name = "kpv";
  runtimeInputs = [mpv];
  text = ''
    mpv --vo=kitty "$@"
  '';
}
