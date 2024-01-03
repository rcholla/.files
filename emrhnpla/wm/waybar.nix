{ config, lib, pkgs, usercfg, ... }:
let
  userpkgs.catppuccin-waybar = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "waybar";
    rev = "v1.0";
    hash = "sha256-vfwfBE3iqIN1cGoItSssR7h0z6tuJAhNarkziGFlNBw=";
  };
in
{
  xdg.configFile."waybar/CatppuccinMocha.css".source = "${userpkgs.catppuccin-waybar}/mocha.css";
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      position = "left";
      layer = "top";
      width = 48;
      spacing = 0;
      margin = "5px";
      modules-left = [ "custom/launcher" "hyprland/workspaces" "hyprland/language" ];
      modules-center = [ "clock" "custom/dothr" "custom/hyprpicker" ];
      modules-right = [ "wlr/taskbar" "tray" "backlight" "memory" "cpu" "disk" "battery" ];
      "custom/launcher" = {
        "format" = "";
        "on-click" = "anyrun";
        "on-click-right" = "wlogout -p layer-shell";
        "tooltip" = false;
      };
      "hyprland/workspaces" = {
        "active-only" = false;
        "all-outputs" = true;
        "format" = "{icon}";
        "format-icons" = {
          "default" = "";
          "active" = "";
        };
        "persistent-workspaces" = { "*" = 4; };
        "show-special" = false;
        "on-click" = "activate";
        "on-scroll-up" = "hyprctl dispatch workspace e-1";
        "on-scroll-down" = "hyprctl dispatch workspace e+1";
      };
      "hyprland/language" = {
        "format-en" = "US";
        "format-tr" = "TR";
        "on-click" = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
        "on-click-right" = "hyprctl switchxkblayout at-translated-set-2-keyboard prev";
      };
      "clock" = {
        "format" = ''{:%H''\n<span overline="single">%M</span>}'';
        "tooltip" = false;
      };
      "custom/dothr" = {
        "format" = "  ";
        "tooltip" = false;
      };
      "custom/hyprpicker" = {
        "format" = "󰈊";
        "on-click" = "hyprpicker -a";
        "tooltip" = false;
      };
      "wlr/taskbar" = {
        "format" = "{icon}";
        "icon-size" = 14;
        "tooltip-format" = "{title}";
        "active-first" = true;
        "on-click" = "activate";
        "on-click-middle" = "close";
        "on-click-right" = "fullscreen";
        "ignore-list" = [ "xwaylandvideobridge" "kitty" "Spotify Premium" ];
      };
      "tray" = {
        "icon-size" = 15;
        "show-passive-items" = true;
        "spacing" = 6;
      };
      "backlight" = {
        "device" = "intel_backlight";
        "format" = "";
        "scroll-step" = 5;
      };
      "memory" = {
        "interval" = 1;
        "format" = "";
        "on-click" = "gnome-system-monitor --show-resources-tab";
      };
      "cpu" = {
        "interval" = 1;
        "format" = "";
        "on-click" = "gnome-system-monitor --show-resources-tab";
      };
      "disk" = {
        "interval" = 60;
        "format" = "";
        "on-click" = "gnome-system-monitor --show-file-systems-tab";
        "on-click-right" = "dolphin --new-window /";
      };
      "battery" = {
        "states" = {
          "warning" = 30;
          "critical" = 15;
        };
        "format" = "{icon}";
        "format-icons" = [ "󰂎" "󰁼" "󰁾" "󰂀" "󰂄" ];
        "tooltip-format" = "{capacity}%";
      };
    };
    style = ''
      @import "CatppuccinMocha.css";

      * {
        margin: 0;
        padding: 0;
        border: none;
        border-radius: 0;
        font-family: ${usercfg.fonts.default.name};
      }

      window#waybar {
        background-color: transparent;
        border: 1px solid @blue;
        color: @text;
      }

      #custom-launcher {
        margin-left: -10px;
        padding-top: 12px;
        font-size: 26px;
        color: @blue;
      }

      #workspaces {
        margin-left: -2px;
        padding-bottom: 4px;
      }
      #workspaces button {
        transition: all 0.3s ease-in-out;
        color: @lavender;
      }
      #workspaces button.active,
      #workspaces button:hover {
        color: @yellow;
      }

      #language {
        margin-left: 2px;
        font-weight: bold;
      }

      #clock {
        font-weight: bold;
        font-size: 18px;
      }

      #custom-dothr {
        margin-left: -2px;
        padding: 2px 0;
        font-size: 12px;
        color: @yellow;
      }

      #custom-hyprpicker {
        margin-left: -2px;
        font-size: 18px;
      }

      #tray {
        margin: 0 12px;
        padding: 5px 0;
        padding-left: 2px;
        border-top: 1px solid @yellow;
        border-bottom: 1px solid @yellow;
      }

      #backlight {
        margin-left: -4px;
        padding-top: 6px;
        padding-bottom: 2px;
        font-size: 18px;
        color: @yellow;
      }

      #memory {
        margin-left: -4px;
        padding-bottom: 2px;
        font-size: 17px;
        color: @peach;
      }

      #cpu {
        margin-left: -6px;
        padding-bottom: 2px;
        font-size: 17px;
        color: @yellow;
      }

      #disk {
        margin-left: -2px;
        padding-bottom: 2px;
        font-size: 18px;
        color: @red;
      }

      #battery {
        margin-left: 1px;
        padding-bottom: 12px;
        font-size: 24px;
        color: @green;
      }
      #battery.warning {
        color: @yellow;
      }
      #battery.critical {
        color: @red;
      }
    '';
  };
}
