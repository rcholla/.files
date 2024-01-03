{ config, lib, pkgs, usercfg, ... }:

{
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "blue"; };
      size = "32x32";
    };
    settings = {
      global = {
        width = 350;
        notification_limit = 20;
        origin = "top-right";
        offset = "15x15";
        progress_bar = true;
        progress_bar_corner_radius = 0;
        frame_width = 1;
        gap_size = 5;
        frame_color = "#89B4FA";
        font = usercfg.fonts.monospace.family;
        stack_duplicates = true;
        hide_duplicate_count = false;
        sticky_history = true;
        history_length = 10;
        corner_radius = 0;
        mouse_left_click = "do_action";
        mouse_middle_click = "open_url";
        mouse_right_click = "close_current";
      };
      urgency_low = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
      };
      urgency_normal = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
      };
      urgency_critical = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#FAB387";
      };
    };
  };
}
