{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  services.dunst = {
    enable = true;
    iconTheme = {
      inherit (T.icons) name;
      package = T.icons.src;
      size = "32x32";
    };
    settings = T.dunst.src.urgency // {
      global = T.dunst.src.global // {
        width = 350;
        notification_limit = 20;
        origin = "top-right";
        offset = "15x15";
        progress_bar = true;
        progress_bar_corner_radius = 0;
        frame_width = 1;
        gap_size = 5;
        font = usercfg.fonts.firaCode.family;
        stack_duplicates = true;
        hide_duplicate_count = false;
        sticky_history = true;
        history_length = 10;
        corner_radius = 0;
        mouse_left_click = "do_action";
        mouse_middle_click = "open_url";
        mouse_right_click = "close_current";
      };
    };
  };
}
