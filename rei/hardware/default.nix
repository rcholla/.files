{ config, lib, pkgs, modulesPath, usercfg, ... }:

{
  imports = [
    (./. + "/${usercfg.host}")
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
}
