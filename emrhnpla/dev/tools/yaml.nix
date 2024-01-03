{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ yaml-language-server ];
}
