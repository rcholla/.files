{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../common
    ./power.nix
    ./graphics.nix
    inputs.nixos-hardware.nixosModules.lenovo-ideapad-15arh05
  ];
}
