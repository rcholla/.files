{ config, lib, pkgs, usercfg, ... }:

{
  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = true;

  users.users.${usercfg.username}.extraGroups = [ "libvirtd" ];
}
