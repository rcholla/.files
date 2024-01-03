{ config, lib, pkgs, ... }:

{
  imports = [
    ./qt.nix
    ./gtk.nix
  ];

  home.pointerCursor = {
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
  };
}
