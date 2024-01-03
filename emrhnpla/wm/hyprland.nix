{ config, lib, pkgs, inputs, usercfg, ... }:
let
  T = usercfg.themes.default;
  hyprlandpkgs.contrib = inputs.hyprland-contrib.packages.${pkgs.system};
  userpkgs = {
    hyprbin-convert-to-gif = pkgs.writeShellApplication {
      name = "hyprbin-convert-to-gif";
      runtimeInputs = with pkgs; [
        coreutils
        ffmpeg
      ];
      text = ''
        file="$1"
        output_dir="$2"
        if [ -f "$file" ]; then
          filename=$(basename "$file")
          filename="''${filename%.*}"
          output="$output_dir/$filename.gif"
          [ ! -d "$output_dir" ] && mkdir -p "$output_dir"
          [ ! -f "$output" ] && ffmpeg -i "$file" "$output"
        fi
        wait
      '';
    };
    hyprbin-effects = pkgs.writeShellApplication {
      name = "hyprbin-effects";
      runtimeInputs = with pkgs; [
        gawk
        hyprland
      ];
      text = ''
        function _fenable { hyprctl reload; }

        function _fdisable {
          hyprctl --batch "\
            keyword animations:enabled 0;\
            keyword decoration:drop_shadow 0;\
            keyword decoration:blur:enabled 0;\
            keyword general:gaps_in 0;\
            keyword general:gaps_out 0;\
            keyword general:border_size 1;\
            keyword decoration:rounding 0"
        }

        function _ftoggle {
          HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
          if [ "$HYPRGAMEMODE" = "1" ]; then
            _fdisable
          else
            _fenable
          fi
        }

        case "$1" in
        enable) _fenable ;;
        disable) _fdisable ;;
        toggle) _ftoggle ;;
        esac
      '';
    };
    hyprbin-focus = pkgs.writeShellApplication {
      name = "hyprbin-focus";
      text = ''
        ${lib.getExe userpkgs.hyprbin-effects} toggle &
        ${lib.getExe userpkgs.hyprbin-waybar} toggle &
        ${lib.getExe userpkgs.hyprbin-wallpaper} toggle &
      '';
    };
    hyprbin-copy-text-from-image = pkgs.writeShellApplication {
      name = "hyprbin-copy-text-from-image";
      runtimeInputs = with pkgs; [
        dunst
        gawk
        grim
        slurp
        tesseract
        wl-clipboard
        zenity
      ];
      excludeShellChecks = [ "SC2059" ];
      text = ''
        target_language=$(zenity --entry --title="Select Language(s)" --text="Enter language(s) separated by '+'")
        available_languages=$(tesseract --list-langs | awk '{print $1}')

        if  [[ -z "$target_language" ]]; then 
          dunstify "No language selected. Defaulting to English"
          target_language="eng"
        fi 

        if [[ "$target_language" == *+* ]]; then
          while IFS= read -r line; do
              target_languages+=("$line")
          done <<< "$(printf "''${target_language//+/\\n}")"

          for lang in "''${target_languages[@]}"; do
            if ! echo "$available_languages" | grep -Fxq "$lang"; then
              dunstify "Language '$lang' not available. Defaulting to English"
              target_language="eng"
              break
            fi
          done
        else
          if ! echo "$available_languages" | grep -Fxq "$target_language"; then
            dunstify "Language '$target_language' not available. Defaulting to English"
            target_language="eng"
          fi
        fi

        grim -g "$(slurp)" - | tesseract -l "$target_language" - - | wl-copy
      '';
    };
    hyprbin-volume = pkgs.writeShellApplication {
      name = "hyprbin-volume";
      runtimeInputs = with pkgs; [
        dunst
        pamixer
      ];
      text = ''
        function _fup {
          pamixer -i "$1"
          volume=$(pamixer --get-volume)
          [ "$volume" -lt 100 ] && volume="expr $volume"
          dunstify -a "VOLUME" "Increasing to $volume%" -h int:value:"$volume" -i audio-volume-high-symbolic -r 2593 -u normal
        }

        function _fdown {
          pamixer -d "$1"
          volume=$(pamixer --get-volume)
          [ "$volume" -gt 0 ] && volume="expr $volume"
          dunstify -a "VOLUME" "Decreasing to $volume%" -h int:value:"$volume" -i audio-volume-low-symbolic -r 2593 -u normal
        }

        function _fmute {
          if [ "$(pamixer --get-mute)" = "true" ]; then
            pamixer -u
            dunstify -a "VOLUME" "UNMUTED" -i audio-volume-high-symbolic -r 2593 -u normal
          else
            pamixer -m
            dunstify -a "VOLUME" "MUTED" -i audio-volume-muted-symbolic -r 2593 -u normal
          fi
        }

        case "$1" in
        up) _fup "$2" ;;
        down) _fdown "$2" ;;
        mute) _fmute ;;
        esac
      '';
    };
    hyprbin-wallpaper = pkgs.writeShellApplication {
      name = "hyprbin-wallpaper";
      runtimeInputs = with pkgs; [
        dunst
        findutils
        mpvpaper
        pamixer
        parallel
        procps
      ];
      text = ''
        find "$WALLPAPERS/mp4" -type f -name "*.mp4" | parallel hyprbin-convert-to-gif {} "$WALLPAPERS/gif"

        function _finit { mpvpaper eDP-1 "${usercfg.wallpapers.desktop.path}" -o "no-audio --loop-playlist"; }

        function _fkill { pkill mpvpaper; }

        function _ftoggle {
          if pgrep mpvpaper; then
            _fkill
          else
            _finit
          fi
        }

        case "$1" in
        init) _finit ;;
        kill) _fkill ;;
        toggle) _ftoggle ;;
        esac
      '';
    };
    hyprbin-waybar = pkgs.writeShellApplication {
      name = "hyprbin-waybar";
      runtimeInputs = with pkgs; [
        procps
        waybar
      ];
      text = ''
        function _finit { waybar; }

        function _fkill { pkill waybar; }

        function _ftoggle {
          if pgrep waybar; then
            pkill -SIGUSR1 waybar
          else
            _finit
          fi
        }

        function _freload { pkill -SIGUSR2 waybar; }

        case "$1" in
        init) _finit ;;
        kill) _fkill ;;
        toggle) _ftoggle ;;
        reload) _freload ;;
        esac
      '';
    };
  };
in
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  home = {
    packages = [
      hyprlandpkgs.contrib.grimblast
      hyprlandpkgs.contrib.scratchpad
      userpkgs.hyprbin-convert-to-gif
      userpkgs.hyprbin-effects
      userpkgs.hyprbin-focus
      userpkgs.hyprbin-copy-text-from-image
      userpkgs.hyprbin-volume
      userpkgs.hyprbin-wallpaper
      userpkgs.hyprbin-waybar
    ];
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      XDG_SESSION_TYPE = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };

  xdg.configFile."hypr/${T.hyprland.name}.conf".source = T.hyprland.src;
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      # $ Hyprland Config;
      # # Monitor;
      monitor= , preffered, 0x0, 1
      # # Source;
      source = $XDG_CONFIG_HOME/hypr/${T.hyprland.name}.conf
      # # Exec;
      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
      exec-once = wl-paste --watch cliphist store &
      exec-once = hyprbin-wallpaper init &
      exec-once = waybar & xwaylandvideobridge &
      # # Options;
      # https://wiki.hyprland.org/Configuring/Variables/#general
      general {
        gaps_in = 1
        gaps_out = 5
        col.active_border = $color12
        col.inactive_border = $color20
        layout = dwindle
        resize_on_border = true
      }
      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration {
        rounding = 0
        inactive_opacity = 0.85
        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = $color25
        blur {
          enabled = true
          size = 12
          passes = 2
          popups = true
        }
      }
      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations {
        enabled = yes
        first_launch_animation = true
        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.1
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = linear, 1, 1, 1, 1
        animation = windows, 1, 6, wind, slide
        animation = windowsIn, 1, 6, winIn, slide
        animation = windowsOut, 1, 5, winOut, slide
        animation = windowsMove, 1, 5, wind, slide
        animation = border, 1, 1, linear
        animation = borderangle, 1, 30, linear, loop
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, wind, slidevert
      }
      # https://wiki.hyprland.org/Configuring/Variables/#cursor
      cursor {
        enable_hyprcursor = false
        inactive_timeout = 2
      }
      # https://wiki.hyprland.org/Configuring/Variables/#input
      input {
        kb_layout = us, tr
        kb_options = caps:escape
        numlock_by_default = true
        repeat_rate = 40
        repeat_delay = 140
      }
      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 6
        workspace_swipe_create_new = false
      }
      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
      }
      # https://wiki.hyprland.org/Configuring/Dwindle-Layout/
      dwindle {
        pseudotile = true
        force_split = 2
      }
      # # Window Rules;
      # Blueman;
      windowrulev2 = float, class:^(.blueman-manager-wrapped)$
      # Bottles;
      windowrulev2 = float, class:^(com.usebottles.bottles)$
      # Okular;
      windowrulev2 = float, class:^(org.kde.okular)$, title:^(New Text Note — Okular)$
      windowrulev2 = center, class:^(org.kde.okular)$, title:^(New Text Note — Okular)$
      windowrulev2 = size 500 200, class:^(org.kde.okular)$, title:^(New Text Note — Okular)$
      # Pavucontrol;
      windowrulev2 = float, class:^(pavucontrol)$, title:^(Volume Control)$
      # Qjackctl;
      windowrulev2 = float, class:^(org.rncbc.qjackctl)$, title:^(JACK Audio Connection Kit \[\(default\)\] Active. — QjackCtl)$
      windowrulev2 = center, class:^(org.rncbc.qjackctl)$, title:^(JACK Audio Connection Kit \[\(default\)\] Active. — QjackCtl)$
      windowrulev2 = size 650 120, class:^(org.rncbc.qjackctl)$, title:^(JACK Audio Connection Kit \[\(default\)\] Active. — QjackCtl)$
      # Steam;
      windowrulev2 = float, class:^(steam)$, title:^(Friends List)$
      windowrulev2 = float, class:^(steam)$, title:^(Steam - News)$
      # Xwaylandvideobridge;
      windowrulev2 = noanim, class:^(xwaylandvideobridge)$
      windowrulev2 = nofocus, class:^(xwaylandvideobridge)$
      windowrulev2 = noinitialfocus, class:^(xwaylandvideobridge)$
      windowrulev2 = opacity 0.0 override 0.0 override, class:^(xwaylandvideobridge)$
      # # Binds; | https://wiki.hyprland.org/Configuring/Binds/
      $mainMod = SUPER 
      # System;
      bind = $mainMod, Q, killactive,
      bind = $mainMod, P, pin, active
      bind = $mainMod_CTRL, C, centerwindow,
      bind = $mainMod_SHIFT, F, fullscreen, 0
      bind = $mainMod_CTRL, F, togglefloating,
      bind = $mainMod_CTRL, G, exec, hyprbin-focus toggle
      bind = $mainMod_CTRL, E, exec, hyprbin-effects toggle
      bind = $mainMod, A, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next
      # Apps;
      bind = $mainMod, T, exec, ${usercfg.env.terminal.name}
      bind = $mainMod, S, exec, anyrun
      bind = $mainMod, E, exec, dolphin
      bind = $mainMod, G, exec, scratchpad
      bind = $mainMod, C, exec, hyprpicker -a
      bind = $mainMod_SHIFT, G, exec, scratchpad -m "wofi -d" -g
      bind = $mainMod_SHIFT, X, exec, hyprlock
      bind = $mainMod, Z, exec, grimblast save area
      bind = $mainMod, X, exec, wlogout -p layer-shell
      bind = $mainMod, TAB, exec, hyprbin-waybar toggle
      bind = $mainMod_SHIFT, T, exec, hyprbin-copy-text-from-image
      bind = $mainMod_SHIFT, TAB, exec, hyprbin-waybar reload
      bind = $mainMod, F, exec, ${usercfg.env.browser.name}
      # Window Focus;
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, J, movefocus, d
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, L, movefocus, r
      # Window Movement on Layout;
      bind = $mainMod_SHIFT, H, movewindow, l
      bind = $mainMod_SHIFT, J, movewindow, d
      bind = $mainMod_SHIFT, K, movewindow, u
      bind = $mainMod_SHIFT, L, movewindow, r
      # Window Movement on Float;
      bind = $mainMod_SHIFT, R, submap, move
      submap = move
      binde = , H, moveactive, -20 0
      binde = , J, moveactive, 0 20
      binde = , K, moveactive, 0 -20
      binde = , L, moveactive, 20 0
      bind = , ESCAPE, submap, reset 
      submap = reset
      # Window Resizing;
      bind = $mainMod_CTRL, R, submap, resize
      submap = resize
      binde = , H, resizeactive, -30 0
      binde = , J, resizeactive, 0 30
      binde = , K, resizeactive, 0 -30
      binde = , L, resizeactive, 30 0
      bind = , ESCAPE, submap, reset 
      submap = reset
      # Workspace Swiping;
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      # Window Movement to Workspace;
      bind = $mainMod_CTRL, 1, movetoworkspace, 1
      bind = $mainMod_CTRL, 2, movetoworkspace, 2
      bind = $mainMod_CTRL, 3, movetoworkspace, 3
      bind = $mainMod_CTRL, 4, movetoworkspace, 4
      bind = $mainMod_CTRL, 5, movetoworkspace, 5
      bind = $mainMod_CTRL, 6, movetoworkspace, 6
      # Silently Window Movement to Workspace;
      bind = $mainMod_SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod_SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod_SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod_SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod_SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod_SHIFT, 6, movetoworkspacesilent, 6
      # Scroll Workspaces;
      bind = $mainMod, mouse_up, workspace, e-1
      bind = $mainMod, mouse_down, workspace, e+1
      # Window Movement/Resizing with Mouse;
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
      # Media;
      bindl = , XF86AudioMedia, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous
      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioStop, exec, playerctl stop
      # Audio;
      bindle = , XF86AudioLowerVolume, exec, hyprbin-volume down 5
      bindle = , XF86AudioRaiseVolume, exec, hyprbin-volume up 5
      bindle = , XF86AudioMute, exec, hyprbin-volume mute
      # Brightness;
      bind = , XF86MonBrightnessDown, exec, brightnessctl set 10%-
      bind = , XF86MonBrightnessUp, exec, brightnessctl set +10%
      # $;
    '';
  };
}
