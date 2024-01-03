{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ardour
    calf
    guitarix
    qjackctl
    tap-plugins
    tenacity
    x42-plugins
  ];
}
