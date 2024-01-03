{ config, lib, pkgs, ... }:

{
  imports = [
    ./sound.nix
    ./kernel.nix
    ./network.nix
    ./bluetooth.nix
    ./filesystem.nix
  ];
}
