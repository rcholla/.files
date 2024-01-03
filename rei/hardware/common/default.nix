{ config, lib, pkgs, ... }:

{
  imports = [
    ./kernel.nix
    ./filesystem.nix
    ./bootloader.nix
    ./network.nix
    ./audio.nix
    ./bluetooth.nix
  ];
}
