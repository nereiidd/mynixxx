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
      "$mod" = "SUPER";
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
        "awww-daemon &"

        "[workspace 4 silent; float; size 1111 700] ${terminal} -e btop"
        "[workspace 4 silent; float; size 800 600] throne"
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
      #  "$mod" = "SUPER";
        layout = "dwindle";
        gaps_in = 3;
        gaps_out = 10;
        border_size = 4;
        "col.active_border" = "rgb(404040)";
        "col.inactive_border" = "rgb(1a1a1a)";
        # border_part_of_window = false;
       # no_border_on_floating = true;
      };
      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
       # new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
      };
      dwindle = {
        force_split = 2;
       # special_scale_factor = 1.0;
       # split_width_multiplier = 1.0;
        use_active_for_splits = true;
       # pseudotile = "yes";
        preserve_split = true;
      };
      master = {
        new_status = "master";
       # special_scale_factor = 1;
      };
      decoration = {
        rounding = 0;
        blur = {
          enabled = true;

          size = 3;
          noise = 0;
          passes = 2;
          contrast = 1.4;
          brightness = 1;

          xray = true;
        };
        shadow = {
          enabled = true;
         # ignore_window = true;
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
        "$mod, F1, exec, show-keybinds"
        # keybindings
        "$mod, Return, exec, ${terminal} --gtk-single-instance=true"
        "ALT, Return, exec, [float; size 1000 600] ${terminal}"
        "$mod SHIFT, Return, exec, [fullscreen] ${terminal}"
        "$mod, B, exec, [workspace 2 silent] ${browser}"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, F, fullscreen, 1"
        "$mod, Space, exec, toggle-float"
        "$mod, D, exec, rofi -show drun || pkill rofi"
        #"$mainMod SHIFT, D, exec, webcord --enable-features=UseOzonePlatform --ozone-platform=wayland"
        #"$mainMod SHIFT, S, exec, hyprctl dispatch exec '[workspace 5 silent] SoundWireServer'"
        #"$mainMod, Escape, exec, swaylock"
        #"ALT, Escape, exec, hyprlock"
        "$mod SHIFT, Escape, exec, power-menu"
        "$mod, P, pseudo,"
        #"$mod, X, togglesplit,"
        "$mod, T, exec, toggle-oppacity"
        "$mod, E, exec, [float; size 800 500] ${fileManager}" # 1111 700
        "$mod SHIFT, B, exec, toggle-waybar"
        "$mod, C ,exec, hyprpicker -a"
        "$mod, W,exec, wallpaper-picker"
        #"$mainMod SHIFT, W,exec, hyprctl dispatch exec '[float; size 925 615] waypaper'"
        "$mod, N, exec, swaync-client -t -sw"
        #"CTRL SHIFT, Escape, exec, hyprctl dispatch exec '[workspace 9] missioncenter'"
        #"$mainMod, equal, exec, woomer"
        # "$mainMod SHIFT, W, exec, vm-start"

        # screenshot
        ",Print, exec, screenshot --area"
        "$mod, Print, exec, screenshot --output"
        "$mod SHIFT, Print, exec, screenshot --swappy"

        # switch focus
        "$mod, left,  movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
        "$mod, left,  alterzorder, top"
        "$mod, right, alterzorder, top"
        "$mod, up,    alterzorder, top"
        "$mod, down,  alterzorder, top"
        "$mod, h, alterzorder, top"
        "$mod, j, alterzorder, top"
        "$mod, k, alterzorder, top"
        "$mod, l, alterzorder, top"

        "CTRL ALT, up, exec, hyprctl dispatch focuswindow floating"
        "CTRL ALT, down, exec, hyprctl dispatch focuswindow tiled"

        # switch workspace
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # same as above, but switch to the workspace
        "$mod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT, 9, movetoworkspacesilent, 9"
        "$mod SHIFT, 0, movetoworkspacesilent, 10"
        "$mod CTRL, c, movetoworkspace, empty"

        # window control
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"

        "$mod CTRL, left, resizeactive, -80 0"
        "$mod CTRL, right, resizeactive, 80 0"
        "$mod CTRL, up, resizeactive, 0 -80"
        "$mod CTRL, down, resizeactive, 0 80"
        "$mod CTRL, h, resizeactive, -80 0"
        "$mod CTRL, j, resizeactive, 0 80"
        "$mod CTRL, k, resizeactive, 0 -80"
        "$mod CTRL, l, resizeactive, 80 0"

        "$mod ALT, left, moveactive,  -80 0"
        "$mod ALT, right, moveactive, 80 0"
        "$mod ALT, up, moveactive, 0 -80"
        "$mod ALT, down, moveactive, 0 80"
        "$mod ALT, h, moveactive,  -80 0"
        "$mod ALT, j, moveactive, 0 80"
        "$mod ALT, k, moveactive, 0 -80"
        "$mod ALT, l, moveactive, 80 0"

        # clipboard manager
        "$mod, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"
      ];

      # binds active in lockscreen
      bindl = [
        # laptop brigthness
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "$mod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
        "$mod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
      ];

      # binds that repeat when held
      binde = [
        ",XF86AudioRaiseVolume,exec, pamixer -i 2"
        ",XF86AudioLowerVolume,exec, pamixer -d 2"
      ];

      # mouse binding
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      # windowrule
      windowrule = [
        "match:class ^(imv)$, float on"
        "match:class ^(mpv)$, float on"
        "match:class ^(zenity)$, float on"
        "match:class ^(waypaper)$, float on"
       # "match:class ^(.sameboy-wrapped)$, float on"
        "match:class ^(org.gnome.Calculator)$, float on"
        "match:class ^(org.gnome.FileRoller)$, float on"
        "match:class ^(org.pulseaudio.pavucontrol)$, float on"

        "match:class ^(rofi)$, pin on"
       # "match:class ^(waypaper)$, pin on"

       # "match:class ^(Aseprite)$, tile on"

        "match:class ^(zenity)$, size 850 500"

       # "match:title ^(Volume Control)$, size 700 450"
       # "match:title ^(Volume Control)$, move 40 55%"

       # "match:title ^(Picture-in-Picture)$, pin on"
       # "match:title ^(Picture-in-Picture)$, float on"

       # "match:class ^(zen-beta)$, workspace 1"
       # "match:class ^(codium)$, workspace 3"
       # "match:class ^(Gimp-2.10)$, workspace 4"
       # "match:class ^(Aseprite)$, workspace 4"
       # "match:class ^(Audacious)$, workspace 5"
       # "match:class ^(spotify)$, workspace 5"
       # "match:class ^(com.obsproject.Studio)$, workspace 8"
       # "match:class ^(discord)$, workspace 10"
       # "match:class ^(WebCord)$, workspace 10"
       # "match:class ^(vesktop)$, workspace 10"

       # "match:class ^(mpv)$, idle_inhibit focus"
       # "match:class ^(zen-beta)$, match:title ^(.*YouTube.*)$, idle_inhibit focus"
       # "match:class ^(zen)$, idle_inhibit fullscreen"

        "match:class ^(xdg-desktop-portal-gtk)$, dim_around on"

        "match:xwayland true, rounding 0"

        # No gaps when only
        "border_size 0, match:float 0, match:workspace w[tv1]"
        "rounding 0, match:float 0, match:workspace w[tv1]"
        "border_size 0, match:float 0, match:workspace f[1]"
        "rounding 0, match:float 0, match:workspace f[1]"
      ];
      # layerrule
      layerrule = [
       # "blur, waybar"
       # "blur, swaync-control-center"
       # "blur, swaync-notification-window"
       # "blur, rofi"
        "match:namespace rofi, dim_around on"
        "match:namespace swaync-control-center, dim_around on"
       # "ignorezero, rofi"

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
