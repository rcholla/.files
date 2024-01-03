{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ (discord.override { withVencord = true; }) ];

  xdg.configFile."Vencord/themes/CatppuccinMocha.theme.css".text = ''
    /**
     * @name Catppuccin Mocha
     * @author winston#0001
     * @authorId 505490445468696576
     * @version 0.2.0
     * @description 🎮 Soothing pastel theme for Discord
     * @website https://github.com/catppuccin/discord
     * **/

    @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
  '';
}
