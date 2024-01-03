{ config, lib, pkgs, usercfg, ... }:
let
  syncthingcfg = usercfg.misc.other.syncthing;
in
{
  services.syncthing = {
    enable = true;
    user = usercfg.username;
    overrideFolders = false;
    openDefaultPorts = true;
    inherit (syncthingcfg) dataDir settings;
  };

  users.users.${usercfg.username}.extraGroups = [ "syncthing" ];
}
