{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cachix
    nil
    nixpkgs-fmt
    statix
  ];
}
