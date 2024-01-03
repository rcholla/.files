{ config, lib, pkgs, usercfg, ... }:

{
  imports = lib.optional usercfg.misc.gaming.bottles.enable ./bottles.nix;

  home.packages = with pkgs; [ samrewritten ];
}
