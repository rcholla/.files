{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  programs.cava = {
    enable = true;
    settings.color = T.cava.src;
  };
}
