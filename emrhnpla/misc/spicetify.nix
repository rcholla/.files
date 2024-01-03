{ config, lib, pkgs, inputs, usercfg, ... }:
let
  T = usercfg.themes.default;
  inherit (inputs) spicetify-nix;
  spicetifypkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    theme = T.spicetify.src;
    colorScheme = T.spicetify.name;
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
      newReleases
      lyricsPlus
    ];
  };
}
