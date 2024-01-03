{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../common
    ./graphics.nix
    ./power.nix
    inputs.nixos-hardware.nixosModules.lenovo-ideapad-15arh05
  ];
}
