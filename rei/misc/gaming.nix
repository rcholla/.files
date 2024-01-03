{ config, lib, pkgs, usercfg, ... }:

{
  programs = {
    steam.enable = usercfg.misc.gaming.steam.enable;
    gamemode.enable = usercfg.misc.gaming.gamemode.enable;
  };

  users.users.${usercfg.username}.extraGroups = lib.optional usercfg.misc.gaming.gamemode.enable "gamemode";
}
