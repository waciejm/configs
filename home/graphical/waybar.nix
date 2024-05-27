{
  config,
  lib,
  ...
}: {
  programs.waybar = lib.mkIf config.waciejm.graphical {
    enable = true;
    systemd.enable = true;
    settings.main-bar = {
      layer = "top";
      position = "top";
      spacing = 20;
      modules-left = ["user"];
      modules-center = [];
      modules-right = [
        "tray"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "disk"
        "backlight"
        "battery#bat0"
        "battery#bat1"
        "clock"
      ];
      pulseaudio = {
        scroll-step = 10;
        format = "{volume}% {icon} {format_source}";
        format-muted = "󰝟  {format_source}";
        format-source = "{volume}%  ";
        format-source-muted = " ";
        format-icons.default = [" " " " " "];
        on-click = "pavucontrol";
        ignored-sinks = ["Easy Effects Sink"];
      };
      network = {
        format-wifi = " ";
        format-ethernet = "󰈀 ";
        format-linked = "No IP";
        format-disconnected = "󰈂 ";
        tooltip-format-wifi = "{essid} ({signalStrength}%) / {ipaddr} on {ifname} via {gwaddr}/{cidr}";
        tooltip-format-ethernet = "{ipaddr} on {ifname} via {gwaddr}/{cidr}";
      };
      cpu = {
        format = "{usage}% 󰻠 ";
        on-click = "alacritty -e htop";
      };
      memory = {
        format = "{}% 󰘚 ";
        on-click = "alacritty -e htop";
      };
      disk.format = "{percentage_used}% 󰉋 ";
      backlight = {
        format = "{percent}% {icon}";
        format-icons = [" " " " " " " " " " " " " " " " " "];
      };
      battery = {
        format = "{capacity} {icon}";
        format-charging = "{capacity}% 󰂄";
        format-plugged = "{capacity}%  ";
        format-icons = [" " " " " " " " " "];
      };
      "battery#bat0".bat = "BAT0";
      "battery#bat1".bat = "BAT1";
      clock.format = "{:%Y-%m-%d %H:%M}";
      tray = {
        spacing = 10;
        reverse-direction = true;
        show-passive-items = true;
      };
    };
    style = ''
      * {
        font-family: IosevkaTerm Nerd Font;
        font-size: 15px;
        font-weight: 600;
        color: rgb(240, 210, 240);
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(48, 36, 52, 0.75);
      }

      .modules-left {
        padding-left: 12px;
        padding-top: 5px;
        padding-bottom: 4px;
      }

      .modules-right {
        padding-right: 12px;
        padding-top: 5px;
        padding-bottom: 4px;
      }
    '';
  };
}
