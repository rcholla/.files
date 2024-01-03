{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./swaylock.nix
    ./kitty.nix
    ./dunst.nix
    ./anyrun.nix
    ./wofi.nix
    ./tray.nix
  ];

  home.packages = with pkgs; [
    gnome.gnome-system-monitor
    hyprpicker
    mpvpaper
    pamixer
    pavucontrol
    swayidle
    wl-clipboard
    wl-gammactl
    wlogout
    wlsunset
    wofi
    xwaylandvideobridge
  ];
}
