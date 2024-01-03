{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  home.pointerCursor = {
    inherit (T.cursor) name;
    package = T.cursor.src;
    size = 24;
  };
}
