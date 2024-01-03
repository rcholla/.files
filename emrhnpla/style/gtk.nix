{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  home = {
    packages = with pkgs; [ gnome-themes-extra ];
    sessionVariables = {
      GDK_BACKEND = usercfg.protocol;
      GTK_USE_PORTAL = "1";
    };
    pointerCursor.gtk.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      inherit (T.gtk) name;
      package = T.gtk.src;
    };
    iconTheme = {
      inherit (T.icons) name;
      package = T.icons.src;
    };
  };
}
