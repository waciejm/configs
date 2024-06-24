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
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = [];
      modules-right = [
        "systemd-failed-units"
        "tray"
        "idle_inhibitor"
        "network"
        "pulseaudio"
        "cpu"
        "memory"
        "disk"
        "backlight"
        "battery"
        "power-profiles-daemon"
        "clock"
      ];
      "hyprland/workspaces" = {
        active-only = false;
        all-outputs = true;
        move-to-monitor = true;
      };
      systemd-failed-units = {
        hide-on-ok = true;
        format = "✗ {nr_failed}";
        system = true;
        user = true;
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
            activated = " ";
            deactivated = " ";
        };
      };
      network = {
        format-wifi = " ";
        format-ethernet = "󰈀 ";
        format-linked = "No IP";
        format-disconnected = "󰈂 ";
        tooltip-format-wifi = "{essid} ({signalStrength}%) / {ipaddr} on {ifname} via {gwaddr}/{cidr}";
        tooltip-format-ethernet = "{ipaddr} on {ifname} via {gwaddr}/{cidr}";
      };
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
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% 󰂄";
        format-plugged = "{capacity}%  ";
        format-icons = [" " " " " " " " " "];
      };
      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = " ";
          performance = " ";
          balanced = " ";
          power-saver = " ";
        };
      };
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

      #workspaces button.urgent {
        color: rgb(255, 50, 50);
      }
      #workspaces button.visible {
        box-shadow: inset 0 -3px rgba(240, 210, 240, 0.3);
      }
      #workspaces button.active {
        box-shadow: inset 0 -3px rgb(240, 210, 240);
      }

      #systemd-failed-units.degraded {
        color: rgb(255, 50, 50);
      }

      #idle_inhibitor.activated {
        color: rgb(255, 50, 50);
      }
    '';
  };
}
