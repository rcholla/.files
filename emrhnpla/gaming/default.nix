{ config, lib, pkgs, ... }:

{
  imports = [ ./bottles.nix ];

  home.packages = with pkgs; [
    flatpak
    samrewritten
    steam
  ];
}
