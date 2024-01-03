{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ silicon ];

  xdg.configFile = {
    "silicon/syntaxes/.keep".text = "";
    "silicon/themes/CatppuccinMocha.tmTheme".source = "${config.programs.bat.themes.CatppuccinMocha.src}/Catppuccin-mocha.tmTheme";
  };
}
