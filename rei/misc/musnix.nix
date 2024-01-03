{ config, lib, pkgs, inputs, usercfg, ... }:

{
  imports = [ inputs.musnix.nixosModules.musnix ];

  musnix.enable = true;

  users.users.${usercfg.username}.extraGroups = [ "audio" ];
}
