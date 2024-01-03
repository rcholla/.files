{ config, lib, pkgs, inputs, usercfg, ... }:
let
  sopscfg = usercfg.misc.other.sops;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  environment.systemPackages = with pkgs; [ sops ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age = {
      generateKey = false;
      sshKeyPaths = [ sopscfg.sshPath ];
    };
    inherit (sopscfg) secrets;
  };

  users.users.${usercfg.username}.hashedPasswordFile = config.sops.secrets.${sopscfg.names.password}.path;
}
