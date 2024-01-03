{ config, lib, pkgs, usercfg, ... }:

{
  home.packages = lib.optionals usercfg.misc.dev.tools.enable (with pkgs; [
    cachix
    nil
    nixd
    nixpkgs-fmt
    statix
  ]);
}
