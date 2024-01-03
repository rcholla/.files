{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  programs.bat = {
    enable = true;
    config.theme = T.bat.name;
    themes.${T.bat.name} = {
      inherit (T.bat) file src;
    };
  };
}
