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
    libreoffice-qt-fresh
    libsForQt5.ark
    libsForQt5.gwenview
    libsForQt5.kdenlive
    libsForQt5.okular
    mypaint
    obsidian
    protonvpn-gui
    qbittorrent
    tor-browser-bundle-bin
    tradingview
    (ungoogled-chromium.override {
      enableWideVine = true;
    })
  ];

  services = {
    easyeffects.enable = true;
    kdeconnect.enable = true;
  };

  programs.obs-studio.enable = true;
}
