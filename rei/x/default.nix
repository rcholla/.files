{ config, lib, pkgs, usercfg, ... }:

{
  imports = lib.optional (usercfg.protocol == "wayland") ./wayland.nix;

  services.xserver = {
    enable = true;
    xkb = {
      inherit (usercfg.locale) layout;
      options = "caps:escape";
    };
    displayManager.startx.enable = true;
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
}
