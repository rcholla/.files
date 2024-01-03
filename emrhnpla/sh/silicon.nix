{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  home.packages = with pkgs; [ silicon ];

  xdg.configFile = {
    "silicon/syntaxes/.keep".text = "";
    "silicon/themes/${T.silicon.name}.tmTheme".source = T.silicon.path;
  };
}
