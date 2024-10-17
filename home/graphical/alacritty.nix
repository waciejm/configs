{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.waciejm.graphical {
    programs.alacritty = {
      enable = true;
      settings = {
        colors = {
          primary = {
            background = "0x1d2021";
            foreground = "0xebdbb2";
          };
          normal = {
            black = "0x1d2021";
            blue = "0x458588";
            cyan = "0x689d6a";
            green = "0x98971a";
            magenta = "0xb16286";
            red = "0xcc241d";
            white = "0xa89984";
            yellow = "0xd79921";
          };
          bright = {
            black = "0x928374";
            blue = "0x83a598";
            cyan = "0x8ec07c";
            green = "0xb8bb26";
            magenta = "0xd3869b";
            red = "0xfb4934";
            white = "0xebdbb2";
            yellow = "0xfabd2f";
          };
        };
        font = {
          size = 12.0;
          normal = {
            family = "IosevkaTerm Nerd Font";
          };
          bold = {
            family = "IosevkaTerm Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "IosevkaTerm Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "IosevkaTerm Nerd Font";
            style = "Bold Italic";
          };
        };
        window = {
          startup_mode = "Windowed";
          decorations = "full";
          opacity = 1.0;
          dimensions = {
            columns = 160;
            lines = 50;
          };
          dynamic_padding = true;
          padding = {
            x = 4;
            y = 4;
          };
        };
        scrolling = {
          multiplier = 10;
        };
      };
    };
  };
}
