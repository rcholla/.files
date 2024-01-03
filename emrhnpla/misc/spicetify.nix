{ config, lib, pkgs, inputs, usercfg, ... }:
let
  T = usercfg.themes.default;
  inherit (inputs) spicetify-nix;
  spicetifypkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    enable = true;
    theme = T.spicetify.src;
    colorScheme = "mocha";
    enabledExtensions = with spicetifypkgs.extensions; [
      autoSkipVideo
      bookmark
      autoSkipExplicit
      fullAppDisplay
      keyboardShortcut
      loopyLoop
      popupLyrics
      shuffle
      trashbin
      webnowplaying
    ];
    enabledCustomApps = with spicetifypkgs.apps; [
      reddit
      new-releases
      lyrics-plus
    ];
  };
}
