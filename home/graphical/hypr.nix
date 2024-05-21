{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = lib.mkIf config.waciejm.graphical {
    enable = true;
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,20"
        "HYPRCURSOR_THEME,HyprBibataModernClassicSVG"
      ];
      monitor = [
        "desc:LG Electronics LG TV SSCR2 0x01010101, 3840x2160@120, 0x0, 1.0"
        "desc:Philips Consumer Electronics Company PHL27M1F5500P UHB2304005838, 2560x1440@144, 0x0, 1.0"
        ",preferred,auto,1"
      ];
      general = {
        border_size = 2;
        gaps_in = 0;
        gaps_out = 0;
        "col.inactive_border" = "rgb(000000)";
        "col.active_border" = "rgb(5F1A82)";
        layout = "master";
      };
      decoration = {
        drop_shadow = false;
        dim_inactive = true;
        dim_strength = 0.15;
        dim_special = 0.3;
        blur = {
          enabled = false;
          size = 9;
          passes = 2;
          ignore_opacity = true;
          xray = true;
          noise = 0.03;
          contrast = 1.5;
          brightness = 0.75;
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.1, 1.0, 0.5, 1.0"
        ];
        animation = [
          "windows, 1, 2, myBezier, popin"
          "border, 1, 2, default"
          "borderangle, 1, 2, default"
          "fade, 1, 2, default"
          "workspaces, 1, 2, default, slidefadevert 30%"
          "specialWorkspace, 1, 2, default, fade"
        ];
      };
      input = {
        kb_layout = "pl";
        repeat_rate = 35;
        repeat_delay = 250;
        sensitivity = 0;
        accel_profile = "flat";
        scroll_method = "2fg";
        follow_mouse = 2;
        float_switch_override_focus = 0;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.25;
          clickfinger_behavior = true;
          tap-to-click = false;
        };
      };
      group = {
        "col.border_active" = "rgba(00000000)";
        "col.border_inactive" = "rgba(00000000)";
        "col.border_locked_active" = "rgba(00000000)";
        "col.border_locked_inactive" = "rgba(00000000)";
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        enable_swallow = false;
        swallow_regex = "Alacritty";
      };
      xwayland = {
        use_nearest_neighbor = false;
      };
      master = {
        allow_small_split = false;
        special_scale_factor = 0.98;
        mfact = 0.50;
        new_is_master = false;
        new_on_top = false;
        no_gaps_when_only = 0;
        orientation = "left";
        inherit_fullscreen = false;
        always_center_master = true;
      };
      cursor = {
        inactive_timeout = 10;
      };
      bind = [
        "SUPER SHIFT ALT, Z, exec, systemctl --user start hyprland-exit.target"
        "SUPER SHIFT ALT, Z, exit"
        "SUPER SHIFT, L, exec, loginctl lock-session"
        "SUPER SHIFT ALT, L, exec, systemctl suspend"

        "SUPER, B, exec, pkill -USR1 waybar"
        "SUPER, SPACE, exec, rofi -show drun"
        "SUPER, R, exec, rofi -show run"

        "SUPER, C, killactive"
        "SUPER, V, togglefloating"
        "SUPER, F, fullscreen, 0"
        "SUPER SHIFT, F, fakefullscreen"

        "SUPER, RETURN, exec, alacritty"
        "SUPER, W, exec, swww img $(random-wallpaper)"
        "SUPER, D, exec, makoctl dismiss"
        "SUPER SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy -t \"image/png\""
        "SUPER SHIFT ALT, S, exec, grim -g \"$(slurp)\" \"/home/waciejm/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png\""
        "SUPER SHIFT, V, exec, wf-recorder -g \"$(slurp)\"  --file=\"/home/waciejm/Pictures/Screenrecs/$(date +%Y%m%d_%H%M%S).mp4\""
        "SUPER SHIFT ALT, V, exec, pkill -INT wf-recorder"

        "SUPER, down, workspace, +1"
        "SUPER, up, workspace, -1"
        "SUPER SHIFT, down, movetoworkspace, +1"
        "SUPER SHIFT, up, movetoworkspace, -1"

        "SUPER, 7, togglespecialworkspace, special:one"
        "SUPER, 8, togglespecialworkspace, special:two"
        "SUPER, 9, togglespecialworkspace, special:tre"
        "SUPER SHIFT, 7, movetoworkspace, special:one"
        "SUPER SHIFT, 8, movetoworkspace, special:two"
        "SUPER SHIFT, 9, movetoworkspace, special:tre"
        "SUPER SHIFT, T, movetoworkspace, e+0"

        "SUPER, J, layoutmsg, cyclenext"
        "SUPER, K, layoutmsg, cycleprev"
        "SUPER, H, splitratio, -0.05"
        "SUPER, L, splitratio, +0.05"
        "SUPER SHIFT, J, layoutmsg, swapnext"
        "SUPER SHIFT, K, layoutmsg, swapprev"
        "SUPER SHIFT, H, layoutmsg, addmaster"
        "SUPER SHIFT, L, layoutmsg, removemaster"
        "SUPER SHIFT, RETURN, layoutmsg, swapwithmaster"

        "SUPER, 4, layoutmsg, orientationleft"
        "SUPER, 5, layoutmsg, orientationcenter"

        "SUPER, left, focusmonitor, -1"
        "SUPER, right, focusmonitor, +1"
        "SUPER SHIFT, left, movewindow, win:-1"
        "SUPER SHIFT, right, movewindow, win:+1"

        ", XF86AudioMute, exec, pamixer --toggle-mute"
        ", XF86AudioLowerVolume, exec, pamixer --decrease 10"
        ", XF86AudioRaiseVolume, exec, pamixer --increase 10"
        ", XF86AudioMicMute, exec, pamixer --source 0 --toggle-mute"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ];
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };

  services.hypridle = lib.mkIf config.waciejm.graphical {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyptctl dispatch dpms on";
        }
      ];
    };
  };

  programs.hyprlock = lib.mkIf config.waciejm.graphical {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };
      background = {
        monitor = "";
        path = "screenshot";
        blur_passes = 2;
        blur_size = 7;
        noise = 0.03;
        contrast = 0.7;
        brightness = 0.7;
        vibrancy = 1.5;
      };
      input-field = {
        monitor = "";
        size = "250, 80";
        outline_thickness = 3;
        rounding = -1;
        outer_color = "rgb(100, 100, 100)";
        inner_color = "rgb(0, 0, 0)";
        font_color = "rgb(150, 150, 150)";
        check_color = "rgb(0, 0, 150)";
        fail_color = "rgb(150, 0, 0)";
        placeholder_text = "";
        fail_text = "(⩺︷⩹)";
        halign = "center";
        valing = "center";
      };
    };
  };

  systemd.user.targets.hyprland-exit = {
    Unit.Conflicts = [
      "graphical-session.target"
      "graphical-session-pre.target"
    ];
  };
}
