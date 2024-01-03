{ config, lib, pkgs, usercfg, ... }:

{
  imports = with usercfg.misc; [
    ./style
    ./sh
    ./wm
    ./misc
  ]
  ++ (lib.optional dev.enable ./dev)
  ++ (lib.optional audio.enable ./audio)
  ++ (lib.optional gaming.enable ./gaming);

  home = with usercfg; {
    stateVersion = "24.05";
    inherit username;
    homeDirectory = dir.home;
    sessionVariables = {
      DOTFILES = dir.dotfiles.self;
      ASSETS = dir.dotfiles.assets;
      WALLPAPERS = dir.dotfiles.wallpapers;
      NEOVIM = dir.dotfiles.neovim;
      BROWSER = env.browser.name;
      EDITOR = env.editor.name;
      TERMINAL = env.terminal.name;
    };
  };

  programs.home-manager.enable = true;
}
