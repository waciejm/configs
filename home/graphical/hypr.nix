{
  config,
  configs-private,
  pkgs,
  selfPkgs,
  lib,
  ...
}: let
  random-wallpaper = (configs-private.mkWallpapers pkgs).random-wallpaper;
  hypr-random-wallpaper = pkgs.writeShellApplication {
    name = "hypr-random-wallpaper";
    runtimeInputs = [
      pkgs.hyprland
      random-wallpaper
    ];
    text = ''
      WALLPAPER="$(random-wallpaper)"
      readonly WALLPAPER
      hyprctl hyprpaper preload "$WALLPAPER"
      hyprctl hyprpaper wallpaper ",$WALLPAPER"
      hyprctl hyprpaper unload unused
    '';
  };
in {
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
        "desc:LG Electronics LG Ultra HD 0x00049402, 1920x1080@60, 0x0, 1.0"
        ",preferred,auto,1"
      ];
      general = {
        border_size = 4;
        gaps_in = 8;
        gaps_out = 16;
        "col.active_border" = "rgb(8B689E)";
        "col.inactive_border" = "rgba(00000000)";
        layout = "master";
      };
      cursor = {
        inactive_timeout = 10;
      };
      decoration = {
        rounding = 20;
        inactive_opacity = 0.75;
        "col.shadow" = "rgb(634A70)";
        "col.shadow_inactive" = "rgba(00000000)";
        dim_special = 0.4;
        blur = {
          enabled = true;
          size = 7;
          passes = 2;
          ignore_opacity = true;
          noise = 0.02;
          contrast = 0.8;
          brightness = 0.25;
          vibrancy = 0.6;
          vibrancy_darkness = 0.6;
        };
      };
      layerrule = [
        "blur, waybar"
      ];
      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.1, 1.0, 0.5, 1.0"
        ];
        animation = [
          "windows, 1, 1, myBezier, popin"
          "border, 1, 1, default"
          "borderangle, 1, 1, default"
          "fade, 1, 1, default"
          "workspaces, 1, 1, default, slidefade 30%"
          "specialWorkspace, 1, 1, default, fade"
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
          tap-to-click = true;
          tap-and-drag = true;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 500;
        workspace_swipe_min_speed_to_force = 10;
        workspace_swipe_cancel_ratio = 0.33;
        workspace_swipe_forever = true;
        workspace_swipe_use_r = true;
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
        special_scale_factor = 0.97;
        mfact = 0.50;
        new_is_master = false;
        new_on_top = false;
        no_gaps_when_only = 0;
        orientation = "left";
        inherit_fullscreen = false;
        always_center_master = true;
      };
      bind = [
        "SUPER SHIFT ALT, Z, exec, systemctl --user start hyprland-exit.target"
        "SUPER SHIFT ALT, Z, exit"
        "SUPER SHIFT ALT, L, exec, loginctl lock-session"

        "SUPER, B, exec, pkill -USR1 waybar"
        "SUPER, SPACE, exec, rofi -show drun"
        "SUPER, R, exec, rofi -show run"

        "SUPER SHIFT, W, exec, ${hypr-random-wallpaper}/bin/hypr-random-wallpaper"

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

        "SUPER, 2, workspace, 1"
        "SUPER, 3, workspace, 2"
        "SUPER, 4, workspace, 3"
        "SUPER, 7, workspace, 4"
        "SUPER, 8, workspace, 5"
        "SUPER, 9, workspace, 6"
        "SUPER SHIFT, 2, movetoworkspace, 1"
        "SUPER SHIFT, 3, movetoworkspace, 2"
        "SUPER SHIFT, 4, movetoworkspace, 3"
        "SUPER SHIFT, 7, movetoworkspace, 4"
        "SUPER SHIFT, 8, movetoworkspace, 5"
        "SUPER SHIFT, 9, movetoworkspace, 6"

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
      ]
      ++ lib.optional (!config.waciejm.laptop) "SUPER SHIFT ALT, right, exec, systemctl suspend"
      ++ lib.optional (config.waciejm.laptop) "SUPER SHIFT ALT, right, exec, systemctl suspend-then-hibernate"
      ;
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      bindl = lib.mkIf config.waciejm.laptop [
        ", switch:Lid Switch, exec, ${selfPkgs.hyprland_lid_switch}/bin/hyprland_lid_switch"
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
          timeout = 150;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 160;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyptctl dispatch dpms on";
        }
      ] ++ lib.optional config.waciejm.laptop {
          timeout = 900;
          on-timeout = "systemctl suspend-then-hibernate";
      };
    };
  };

  programs.hyprlock = lib.mkIf config.waciejm.graphical {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        no_fade_in = true;
        ignore_empty_input = false;
      };
      background = {
        monitor = "";
        path = "screenshot";
        blur_size = 5;
        blur_passes = 3;
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

  services.hyprpaper = lib.mkIf config.waciejm.graphical {
    enable = true;
    settings = {
      splash = false;
      ipc = true;
    };
  };

  systemd.user = lib.mkIf config.waciejm.graphical {
    services.hyprpaper-init = {
      Install.WantedBy = ["hyprpaper.service"];
      Unit = {
        After = ["hyprpaper.service"];
        Description = "hyprpaper init wallpaper";
      };
      Service = {
        Type = "oneshot";
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
        ExecStart = "${hypr-random-wallpaper}/bin/hypr-random-wallpaper";
      };
    };
    
    targets.hyprland-exit = {
      Unit.Conflicts = [
        "graphical-session.target"
        "graphical-session-pre.target"
      ];
    };
  };
}
