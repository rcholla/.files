{ config, lib, pkgs, usercfg, ... }:

{
  imports = with usercfg.misc; [
    ./piper.nix
    ./polkit.nix
    ./postgres.nix
    ./virt-manager.nix
    (if sops.enable then ./sops.nix else null)
    (if syncthing.enable then ./syncthing.nix else null)
  ];

  security.pam.services.swaylock = { };

  services = {
    gnome.gnome-keyring.enable = true;
    hardware.openrgb.enable = true;
    flatpak.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    dbus.enable = true;
  };

  programs = {
    droidcam.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    steam.enable = true;
    zsh.enable = true;
    adb.enable = true;
  };
}
