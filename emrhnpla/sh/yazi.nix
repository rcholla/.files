{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  xdg.configFile."yazi/theme.toml".source = T.yazi.path;
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      show_symlink = true;
      show_hidden = true;
    };
  };
}
