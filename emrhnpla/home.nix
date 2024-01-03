{ config, lib, pkgs, usercfg, ... }:

{
  home = {
    stateVersion = "23.11";
    inherit (usercfg) username;
    homeDirectory = usercfg.dir.home;
    sessionVariables = with usercfg; {
      DOTFILES = dir.dotfiles.self;
      ASSETS = dir.dotfiles.assets;
      WALLPAPERS = dir.dotfiles.wallpapers;
      BROWSER = env.browser.name;
      EDITOR = env.editor.name;
      TERMINAL = env.terminal.name;
    };
  };

  programs.home-manager.enable = true;

  imports = [
    ./style
    ./sh
    ./wm
    ./dev
    ./misc
    ./gaming
  ];
}
