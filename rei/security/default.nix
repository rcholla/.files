{ config, lib, pkgs, usercfg, ... }:

{
  security = {
    sudo = {
      enable = true;
      extraRules = [{
        users = [ usercfg.username ];
        commands = [{
          command = "ALL";
          options = [ "NOPASSWD" ];
        }];
      }];
    };
    doas = {
      enable = true;
      extraRules = [{
        users = [ usercfg.username ];
        keepEnv = true;
        noPass = true;
      }];
    };
  };
}
