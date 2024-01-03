{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      powerManagement.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
    };
  };
}
