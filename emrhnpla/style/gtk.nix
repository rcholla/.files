{ config, lib, pkgs, usercfg, ... }:

{
  home = {
    packages = with pkgs; [ gnome.gnome-themes-extra ];
    sessionVariables = {
      GDK_BACKEND = usercfg.protocol;
      GTK_USE_PORTAL = "1";
    };
    pointerCursor.gtk.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "blue" ];
        size = "standard";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "blue"; };
    };
  };
}
