{
  coreutils,
  jq,
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "hyprland_lid_switch";
  runtimeInputs = [
    coreutils
    jq
  ];
  text = ''
    NUM_MONITORS=$(hyprctl -j monitors | jq length)
    readonly NUM_MONITORS

    LID_STATE=$(< /proc/acpi/button/lid/LID0/state cut -d':' -f2 | tr -d ' ')
    readonly LID_STATE

    case $LID_STATE in
        closed)
        if [[ $NUM_MONITORS -gt 1 ]]; then
          hyprctl keyword monitor "eDP-1, disable"
        fi
        ;;
        open*)
        hyprctl keyword monitor "eDP-1, preferred, auto, 1"
        ;;
        *)
        # LID is open by default
        echo unknown
        exit 0
        ;;
    esac
  '';
}
