{ config, lib, pkgs, usercfg, ... }:

{
  users = {
    defaultUserShell = usercfg.env.shell.pkg;
    users.${usercfg.username} = {
      isNormalUser = true;
      description = usercfg.username;
      extraGroups = [ "wheel" ];
    };
  };
}
