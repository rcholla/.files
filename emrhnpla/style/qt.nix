{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  home = {
    packages = with pkgs; [
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];
    sessionVariables.QT_QPA_PLATFORM = usercfg.protocol;
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum-dark";
      package = T.qt.src;
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" { General.theme = T.qt.name; };
}
