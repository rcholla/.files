{ config, lib, pkgs, usercfg, ... }:

{
  imports = with usercfg.misc; [ ./polkit.nix ]
    ++ (lib.optional gaming.enable ./gaming.nix)
    ++ (lib.optional audio.musnix.enable ./musnix.nix)
    ++ (lib.optional other.sops.enable ./sops.nix)
    ++ (lib.optional other.piper.enable ./piper.nix)
    ++ (lib.optional other.postgres.enable ./postgres.nix)
    ++ (lib.optional other.syncthing.enable ./syncthing.nix)
    ++ (lib.optional other.virt-manager.enable ./virt-manager.nix);

  services = {
    gnome.gnome-keyring.enable = true;
    hardware.openrgb.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    dbus.enable = true;
  };

  programs = {
    droidcam.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    zsh.enable = true;
    adb.enable = true;
  };
}
