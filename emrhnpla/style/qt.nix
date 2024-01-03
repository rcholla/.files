{ config, lib, pkgs, usercfg, ... }:

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
    platformTheme = "qtct";
    style = {
      name = "kvantum-dark";
      package = pkgs.catppuccin-kvantum.override {
        variant = "Mocha";
        accent = "Blue";
      };
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" { General.theme = "Catppuccin-Mocha-Blue"; };
}
