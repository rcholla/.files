{ config, lib, pkgs, ... }:

{
  imports = [
    ./discord.nix
    ./firefox.nix
    ./spicetify.nix
  ];

  home.packages = with pkgs; [
    aseprite
    blender
    bruno
    dolphin
    gparted
    inkscape
    libsForQt5.ark
    libsForQt5.gwenview
    libsForQt5.kdenlive
    libsForQt5.okular
    mypaint
    obsidian
    onlyoffice-bin_latest
    protonvpn-gui
    qbittorrent
    tor-browser-bundle-bin
    tradingview
    ungoogled-chromium
  ];

  services = {
    easyeffects.enable = true;
    kdeconnect.enable = true;
  };

  programs.obs-studio.enable = true;
}
