{ config, lib, pkgs, inputs, usercfg, ... }:

{
  system.stateVersion = "23.11";

  environment = {
    systemPackages = with pkgs; [
      gcc
      git
      gnumake
      htop
      neovim
      vim
      which
    ];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  imports = [
    ./nix
    ./hardware
    ./boot
    ./locale
    ./security
    ./users
    ./fonts
    ./x
    ./misc
  ];
}
