{
  gnused,
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "fix-cosmic-keymap";
  runtimeInputs = [gnused];
  text = ''
    sed -i -e 's/layout: "",/layout: "pl",/g' "$HOME/.config/cosmic/com.system76.CosmicComp/v1/xkb_config"
  '';
}
