{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./idle.nix
    ./waybar.nix
    ./kitty.nix
    ./dunst.nix
    ./anyrun.nix
    ./wofi.nix
    ./tray.nix
  ];

  home.packages = with pkgs; [
    gnome-system-monitor
    hyprpicker
    mpvpaper
    pamixer
    pavucontrol
    wl-clipboard
    wl-gammactl
    wlogout
    wlsunset
    wofi
    xwaylandvideobridge
  ];
}
