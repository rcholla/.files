{ config, lib, pkgs, ... }:
let
  boot = "819A-5277";
  root = "dc01002b-5d6b-455b-a716-68ccf00a3f69";
  swap = "47797ed0-315d-45c5-b3c3-2f1efcad53b4";
  luks = {
    root = "305afd6c-e819-47b7-8551-44b2119c40ea";
    swap = "2a2d0044-d3f4-4d70-a8e5-0d4eedcd5f8a";
  };
in
{
  boot.initrd.luks.devices = {
    "luks-${luks.root}".device = "/dev/disk/by-uuid/${luks.root}";
    "luks-${luks.swap}".device = "/dev/disk/by-uuid/${luks.swap}";
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/${boot}";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-uuid/${root}";
      fsType = "ext4";
    };
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/${swap}"; }];
}
