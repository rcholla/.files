{ config, lib, pkgs, usercfg, ... }:

{
  services.syncthing = {
    enable = true;
    user = usercfg.username;
    overrideFolders = false;
    openDefaultPorts = true;
    inherit (usercfg.misc.syncthing) dataDir settings;
  };

  users.users.${usercfg.username}.extraGroups = [ "syncthing" ];
}
