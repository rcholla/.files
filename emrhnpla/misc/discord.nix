{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  home.packages = with pkgs; [ (discord.override { withVencord = true; }) ];

  xdg.configFile."Vencord/themes/${T.vencord.name}.theme.css".text = T.vencord.src;
}
