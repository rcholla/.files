{ config, lib, pkgs, usercfg, ... }:

{
  networking = {
    hostName = usercfg.hostname;
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # 1714..1764 -> KDEConnect;
      allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
      allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
    };
  };

  users.users.${usercfg.username}.extraGroups = [ "networkmanager" ];
}
