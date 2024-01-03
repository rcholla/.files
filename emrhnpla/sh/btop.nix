{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  xdg.configFile."btop/themes/${T.btop.name}.theme".source = T.btop.path;
  programs.btop = {
    enable = true;
    settings = {
      color_theme = T.btop.name;
      vim_keys = true;
    };
  };
}
