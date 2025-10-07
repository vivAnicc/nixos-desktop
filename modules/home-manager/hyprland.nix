{ inputs, pkgs, ... }:

{
  # This shouldn't be here
  home.packages = [
    pkgs.swaynotificationcenter
    pkgs.yazi
    pkgs.hyprshot
    pkgs.hyprlock

    pkgs.qt5.qtwayland
    pkgs.qt6.qtwayland
    pkgs.libsForQt5.qt5ct
    pkgs.qt6ct
    pkgs.wl-clipboard

    inputs.zen-browser.packages."${pkgs.system}".default

    # Fix xdg-open trying to use "x-terminal-emulator" to open terminals
    (pkgs.writeShellScriptBin "x-terminal-emulator" "ghostty $@")
  ];

  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
    NVD_BACKEND = "direct";

    XCURSOR_SIZE = 24;
    HYPRCURSOR_SIZE = 24;
  };

  wayland.windowManager.hyprland = {
    systemd.variables = ["--all"];
    enable = true;
    package = null;
    portalPackage = null;

    xwayland.enable = true;

    settings = {
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "__GL_GSYNC_ALLOWED,0"
        "__GL_VRR_ALLOWED,0"
        "QT_QPA_PLATFORM,wayland"
        "XCURSOR_SIZE,24"
        "NIXOS_OZONE_WL,1"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      monitor = ",preferred,auto,auto";

      "$terminal" = "${pkgs.fish}/bin/fish -c 'term'";
      "$fileManager" = "${pkgs.fish}/bin/fish -c 'term explorer'";
      "$browser" = "${pkgs.qutebrowser}/bin/qutebrowser";
      "$menu" = "${pkgs.wofi}/bin/wofi -n --show drun";

      cursor = {
        inactive_timeout = 10;
        no_hardware_cursors = true;
      };

      exec-once = [
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.swaynotificationcenter}/bin/swaync"
        "${pkgs.keyutils}/bin/keyctl link @u @s"
        # "${pkgs.nordvpn}/bin/nordvpn connect italy"
      ];

      general = {
        gaps_in = "5";
        gaps_out = "20";

        border_size = "2";

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors"
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps"
        resize_on_border = "false";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on"
        allow_tearing = "false";

        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        # rounding_power = 2

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
      
# Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
# "Smart gaps" / "No gaps when only"
# uncomment all if you wish to use that.
# workspace = w[tv1], gapsout:0, gapsin:0
# workspace = f[1], gapsout:0, gapsin:0
# windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
# windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
# windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
# windowrulev2 = rounding 0, floating:0, onworkspace:f[1]

      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
      };

      input = {
        kb_layout = "it";
        kb_variant = "";
        kb_model = "";
        kb_options = "caps:escape";
        kb_rules = "";

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        numlock_by_default = true;

        touchpad.natural_scroll = false;
      };

      # gestures.workspace_swipe = false;

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bind = [
        "SUPER, Return, exec, ${pkgs.ydotool}/bin/ydotool key 125:0 && sleep 0.1 && ${pkgs.ydotool}/bin/ydotool click C0"

        "SUPER, m, movetoworkspacesilent, special"
        "SUPER, s, togglespecialworkspace"

        ", PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m window"

        "SUPER_SHIFT, q, exit,"

        "SUPER, r, exec, lights on"

        "SUPER, f11, fullscreen"

        # "SUPER, c, exec, ${pkgs.fish}/bin/fish -c 'term bwup'"
        # "SUPER, u, exec, ${pkgs.fish}/bin/fish -c 'term bwu'"
        # "SUPER, p, exec, ${pkgs.fish}/bin/fish -c 'term bwp'"
        # "SUPER, a, exec, ${pkgs.fish}/bin/fish -c 'term bwa'"

        "SUPER, c, exec, ${pkgs.rofi}/bin/rofi -show run"

        "SUPER, Backspace, exec, ${pkgs.hyprlock}/bin/hyprlock"

        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        "SUPER, Tab, cyclenext"
        "SUPER, Tab, bringactivetotop"
        "SUPER_SHIFT, Tab, cyclenext, prev"
        "SUPER_SHIFT, Tab, bringactivetotop"

        "SUPER, less, workspace, -1,"
        "SUPER_SHIFT, less, workspace, +1,"

        "SUPER, minus, workspace, previous"

        "SUPER_SHIFT, h, movewindow, l"
        "SUPER_SHIFT, l, movewindow, r"
        "SUPER_SHIFT, k, movewindow, u"
        "SUPER_SHIFT, j, movewindow, d"

        "SUPER_CTRL, h, movetoworkspacesilent, -1"
        "SUPER_CTRL, l, movetoworkspacesilent, +1"
        "SUPER_CTRL, left, movetoworkspacesilent, -1"
        "SUPER_CTRL, right, movetoworkspacesilent, +1"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER_SHIFT, 8, movetoworkspacesilent, 8"
        "SUPER_SHIFT, 9, movetoworkspacesilent, 9"
        "SUPER_SHIFT, 0, movetoworkspacesilent, 10"

        "SUPER, d, killactive"
        "SUPER_SHIFT, d, forcekillactive"

        "SUPER, w, exec, $terminal"
#TODO: move this in a script, so you can abort if you hit escape (returns empty)
        "SUPER, e, exec, fish -c \"term explorer ~/\\\"$(choose-dir ~)\\\"\""
        # "SUPER, e, exec, $fileManager"
        "SUPER, b, exec, $browser"
        "SUPER, z, exec, ${inputs.zen-browser.packages.${pkgs.system}.default}/bin/zen"
        "SUPER, Space, exec, $menu"
        "SUPER, o, exec, ${pkgs.wofi}/bin/wofi -n --show run"

        "SUPER, v, togglesplit"
        "SUPER, f, togglefloating"
      ];

      "$rosewater" = "rgb(f5e0dc)";
      "$rosewaterAlpha" = "f5e0dc";

      "$flamingo" = "rgb(f2cdcd)";
      "$flamingoAlpha" = "f2cdcd";

      "$pink" = "rgb(f5c2e7)";
      "$pinkAlpha" = "f5c2e7";

      "$mauve" = "rgb(cba6f7)";
      "$mauveAlpha" = "cba6f7";

      "$red" = "rgb(f38ba8)";
      "$redAlpha" = "f38ba8";

      "$maroon" = "rgb(eba0ac)";
      "$maroonAlpha" = "eba0ac";

      "$peach" = "rgb(fab387)";
      "$peachAlpha" = "fab387";

      "$yellow" = "rgb(f9e2af)";
      "$yellowAlpha" = "f9e2af";

      "$green" = "rgb(a6e3a1)";
      "$greenAlpha" = "a6e3a1";

      "$teal" = "rgb(94e2d5)";
      "$tealAlpha" = "94e2d5";

      "$sky" = "rgb(89dceb)";
      "$skyAlpha" = "89dceb";

      "$sapphire" = "rgb(74c7ec)";
      "$sapphireAlpha" = "74c7ec";

      "$blue" = "rgb(89b4fa)";
      "$blueAlpha" = "89b4fa";

      "$lavender" = "rgb(b4befe)";
      "$lavenderAlpha" = "b4befe";

      "$text" = "rgb(cdd6f4)";
      "$textAlpha" = "cdd6f4";

      "$subtext1" = "rgb(bac2de)";
      "$subtext1Alpha" = "bac2de";

      "$subtext0" = "rgb(a6adc8)";
      "$subtext0Alpha" = "a6adc8";

      "$overlay2" = "rgb(9399b2)";
      "$overlay2Alpha" = "9399b2";

      "$overlay1" = "rgb(7f849c)";
      "$overlay1Alpha" = "7f849c";

      "$overlay0" = "rgb(6c7086)";
      "$overlay0Alpha" = "6c7086";

      "$surface2" = "rgb(585b70)";
      "$surface2Alpha" = "585b70";

      "$surface1" = "rgb(45475a)";
      "$surface1Alpha" = "45475a";

      "$surface0" = "rgb(313244)";
      "$surface0Alpha" = "313244";

      "$base" = "rgb(1e1e2e)";
      "$baseAlpha" = "1e1e2e";

      "$mantle" = "rgb(181825)";
      "$mantleAlpha" = "181825";

      "$crust" = "rgb(11111b)";
      "$crustAlpha" = "11111b";
    };
  };
}
