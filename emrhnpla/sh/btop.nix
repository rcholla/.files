{ config, lib, pkgs, ... }:
let
  userpkgs.catppuccin-btop = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "btop";
    rev = "1.0.0";
    hash = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
  };
in
{
  xdg.configFile."btop/themes/CatppuccinMocha.theme".source = "${userpkgs.catppuccin-btop}/themes/catppuccin_mocha.theme";
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "CatppuccinMocha";
      vim_keys = true;
    };
  };
}
