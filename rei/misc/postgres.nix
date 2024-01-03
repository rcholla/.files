{ config, lib, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    authentication = lib.mkOverride 10 ''
      # TYPE  DATABASE  USER  ADDRESS  METHOD
      local   all       all            trust
      host    all       all   all      md5
    '';
  };
}
