{ config, lib, pkgs, ... }:

{
  programs.xwayland.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
