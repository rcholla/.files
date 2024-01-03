{ config, lib, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General.Experimental = "true";
      Policy.AutoEnable = "true";
    };
  };

  services.blueman.enable = true;

  systemd.services.bluetooth.preStart = "${pkgs.util-linux}/bin/rfkill unblock bluetooth";
}
