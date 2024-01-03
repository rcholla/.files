{ config, lib, pkgs, ... }:

{
  imports = [
    ./discord.nix
    ./firefox.nix
    ./obsidian.nix
    ./spicetify.nix
  ];

  home.packages = with pkgs; [
    aseprite
    blender
    bruno
    dolphin
    easyeffects
    gparted
    inkscape
    libreoffice-fresh
    libsForQt5.ark
    libsForQt5.gwenview
    libsForQt5.kdenlive
    mypaint
    obs-studio
    protonvpn-gui
    qbittorrent
    qjackctl
    tor-browser-bundle-bin
    tradingview
    ungoogled-chromium
  ];

  services.kdeconnect.enable = true;
}
