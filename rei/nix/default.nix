{ config, lib, pkgs, usercfg, ... }:

{
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" usercfg.username ];
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault usercfg.system;
}
