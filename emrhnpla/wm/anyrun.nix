{ config, lib, pkgs, inputs, ... }:
let
  inherit (inputs) anyrun;
  anyrunpkgs = anyrun.packages.${pkgs.system};
in
{
  imports = [ anyrun.homeManagerModules.default ];

  programs.anyrun = {
    enable = true;
    config = {
      y.fraction = 0.4;
      width.fraction = 0.3;
      hideIcons = false;
      ignoreExclusiveZones = true;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = null;
      plugins = with anyrunpkgs; [
        applications
        rink
        shell
        translate
        kidex
        dictionary
        websearch
      ];
    };
    extraCss = ''
      * {
        border-radius: 0;
      }

      window {
        background-color: rgba(0, 0, 0, 0.2);
      }

      main {
        background-color: rgb(17, 17, 27);
        border: 1px solid rgb(243, 139, 168);
      }

      entry {
      }

      match {
      }
      match-title {
      }
      match-desc {
      }

      plugin {
      }
    '';
  };
}
