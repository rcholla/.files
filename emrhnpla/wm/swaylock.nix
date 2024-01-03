{ config, lib, pkgs, usercfg, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      fade-in = "0.5";
      font = usercfg.fonts.monospace.name;
      grace = "2";
      ignore-empty-password = true;
      image = usercfg.wallpapers.lockscreen.path "gif";
      indicator = true;
      indicator-radius = "150";
      indicator-thickness = "4";
      inside-clear-color = "cdd6f480";
      inside-color = "1e1e2e80";
      key-hl-color = "89b4fa";
      line-color = "00000000";
      ring-clear-color = "f38ba8";
      ring-color = "f38ba8";
      separator-color = "00000000";
      text-clear-color = "11111b";
      text-color = "b4befe";
    };
  };
}
