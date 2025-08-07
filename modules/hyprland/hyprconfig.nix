{ ... }:
let
  browser = "firefox";
  terminal = "ghostty"; # ghostty --gtk-single-instance=true
  editor = "";
  fileManager = "nemo";
in
{
  wayland.windowManager.hyprland = {
    settings = {
      debug = {
        disable_logs = false;
      };
      env = [
       "HYPRCURSOR_SIZE,24"

      ];
      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "${terminal} --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
        "wl-clip-persist --clipboard both &"
        "wl-paste --watch cliphist store &"
        "waybar &"
        "swaync &"
        "swww-daemon &"

        "[workspace 4 silent; float; size 1111 700] ${terminal} -e btop"
        "[workspace 4 silent; float; size 800 600] nekoray"
      ];
      input = {
        kb_layout = "us,ir";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle";
        kb_rules = "";
        numlock_by_default = true;
        repeat_delay = 300;
        follow_mouse = 1;
        float_switch_override_focus = 0;
        mouse_refocus = 0;
        sensitivity = -0.44;
        accel_profile = "flat";
       # force_no_accel = true;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
        };
      };
      device = {
        name = "elan072b:00-04f3:31bf-touchpad";
        sensitivity = 0.0;
      };
      general = {
        "$mainMod" = "SUPER";
        layout = "dwindle";
        gaps_in = 3;
        gaps_out = 10;
        border_size = 4;
        "col.active_border" = "rgb(404040)";
        "col.inactive_border" = "rgb(1a1a1a)";
        # border_part_of_window = false;
        no_border_on_floating = true;
      };
      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
      };
      dwindle = {
        force_split = 2;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };
      master = {
        new_status = "master";
        special_scale_factor = 1;
      };
      decoration = {
        rounding = 4;
         active_opacity = 0.90;
         inactive_opacity = 0.90;
         fullscreen_opacity = 1.0;
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };
        shadow = {
          enabled = true;
          ignore_window = true;
          offset = "0 2";
          range = 20;
          render_power = 3;
          color = "rgba(00000055)";
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "fade_curve, 0, 0.55, 0.45, 1"
        ];
        animation = [
          # name, enable, speed, curve, style
          # Windows
          "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
          "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
          "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.
          # Fade
          "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
          "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
          "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
          # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
          # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };
      binds = {
        movefocus_cycles_fullscreen = true;
      };
      bind = [
        # show keybinds list
        "$mainMod, F1, exec, show-keybinds"
        # keybindings
        "$mainMod, Return, exec, ${terminal} --gtk-single-instance=true"
        "ALT, Return, exec, [float; size 1000 600] ${terminal}"
        "$mainMod SHIFT, Return, exec, [fullscreen] ${terminal}"
        "$mainMod, B, exec, [workspace 2 silent] ${browser}"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, F, fullscreen, 0"
        "$mainMod SHIFT, F, fullscreen, 1"
        "$mainMod, Space, exec, toggle-float"
        "$mainMod, D, exec, rofi -show drun || pkill rofi"
        #"$mainMod SHIFT, D, exec, webcord --enable-features=UseOzonePlatform --ozone-platform=wayland"
        #"$mainMod SHIFT, S, exec, hyprctl dispatch exec '[workspace 5 silent] SoundWireServer'"
        #"$mainMod, Escape, exec, swaylock"
        #"ALT, Escape, exec, hyprlock"
        "$mainMod SHIFT, Escape, exec, power-menu"
        "$mainMod, P, pseudo,"
        "$mainMod, X, togglesplit,"
        "$mainMod, T, exec, toggle-oppacity"
        "$mainMod, E, exec, [float; size 800 500] ${fileManager}" # 1111 700
        "$mainMod SHIFT, B, exec, toggle-waybar"
        "$mainMod, C ,exec, hyprpicker -a"
        "$mainMod, W,exec, wallpaper-picker"
        #"$mainMod SHIFT, W,exec, hyprctl dispatch exec '[float; size 925 615] waypaper'"
        "$mainMod, N, exec, swaync-client -t -sw"
        #"CTRL SHIFT, Escape, exec, hyprctl dispatch exec '[workspace 9] missioncenter'"
        #"$mainMod, equal, exec, woomer"
        # "$mainMod SHIFT, W, exec, vm-start"

        # screenshot
        ",Print, exec, screenshot --area"
        "$mainMod, Print, exec, screenshot --output"
        "$mainMod SHIFT, Print, exec, screenshot --swappy"

        # switch focus
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"
        "$mainMod, left,  alterzorder, top"
        "$mainMod, right, alterzorder, top"
        "$mainMod, up,    alterzorder, top"
        "$mainMod, down,  alterzorder, top"
        "$mainMod, h, alterzorder, top"
        "$mainMod, j, alterzorder, top"
        "$mainMod, k, alterzorder, top"
        "$mainMod, l, alterzorder, top"

        "CTRL ALT, up, exec, hyprctl dispatch focuswindow floating"
        "CTRL ALT, down, exec, hyprctl dispatch focuswindow tiled"

        # switch workspace
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # same as above, but switch to the workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        "$mainMod CTRL, c, movetoworkspace, empty"

        # window control
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, j, movewindow, d"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, l, movewindow, r"

        "$mainMod CTRL, left, resizeactive, -80 0"
        "$mainMod CTRL, right, resizeactive, 80 0"
        "$mainMod CTRL, up, resizeactive, 0 -80"
        "$mainMod CTRL, down, resizeactive, 0 80"
        "$mainMod CTRL, h, resizeactive, -80 0"
        "$mainMod CTRL, j, resizeactive, 0 80"
        "$mainMod CTRL, k, resizeactive, 0 -80"
        "$mainMod CTRL, l, resizeactive, 80 0"

        "$mainMod ALT, left, moveactive,  -80 0"
        "$mainMod ALT, right, moveactive, 80 0"
        "$mainMod ALT, up, moveactive, 0 -80"
        "$mainMod ALT, down, moveactive, 0 80"
        "$mainMod ALT, h, moveactive,  -80 0"
        "$mainMod ALT, j, moveactive, 0 80"
        "$mainMod ALT, k, moveactive, 0 -80"
        "$mainMod ALT, l, moveactive, 80 0"

        # clipboard manager
        "$mainMod, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"
      ];

      # binds active in lockscreen
      bindl = [
        # laptop brigthness
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
        "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
      ];

      # binds that repeat when held
      binde = [
        ",XF86AudioRaiseVolume,exec, pamixer -i 2"
        ",XF86AudioLowerVolume,exec, pamixer -d 2"
      ];

      # mouse binding
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      # windowrule
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
      # layerrule
      layerrule = [
        "blur, waybar"
       # "blur, swaync-control-center"
       # "blur, swaync-notification-window"
        "blur, rofi"
        "ignorezero, rofi"

      ];
      workspace = [
       # "w[t1], gapsout:0, gapsin:0"
       # "w[tg1], gapsout:0, gapsin:0"
       # "f[1], gapsout:0, gapsin:0"
      ];
    };
    extraConfig = "
      monitor=, 1366x768@60, auto, 1   # 0.666667
      xwayland {
        force_zero_scaling = true
      }
    ";
  };
}
