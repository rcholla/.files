{ config, lib, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config.theme = "CatppuccinMocha";
    themes.CatppuccinMocha = {
      file = "Catppuccin-mocha.tmTheme";
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "main";
        hash = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
      };
    };
  };
}
