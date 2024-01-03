{ config, lib, pkgs, ... }:

{
  imports = [
    ./nix
    ./hardware
    ./locale
    ./security
    ./users
    ./fonts
    ./x
    ./misc
  ];

  system.stateVersion = "24.05";

  environment.systemPackages = with pkgs; [
    coreutils
    gcc
    git
    gnumake
    home-manager
    htop
    neovim
    vim
  ];
}
