{ config, lib, pkgs, inputs, usercfg, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  environment.systemPackages = with pkgs; [ sops ];

  sops = {
    inherit (usercfg.misc.sops) secrets;
    defaultSopsFile = ../../secrets/secrets.yaml;
    age = {
      generateKey = false;
      sshKeyPaths = [ "${usercfg.dir.home}/.ssh/id_ed25519" ];
    };
  };

  users.users.${usercfg.username}.hashedPasswordFile = config.sops.secrets.${usercfg.misc.sops.password}.path;
}
