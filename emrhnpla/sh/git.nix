{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  home.packages = with pkgs; [ pre-commit ];

  programs = {
    git = {
      enable = true;
      userName = usercfg.fullname;
      userEmail = usercfg.email;
      attributes = [ "*.lockb diff=lockb" ];
      extraConfig = {
        init.defaultBranch = "master";
        safe.directory = "*";
        pull.rebase = true;
      };
      lfs.enable = true;
    };
    lazygit = {
      enable = true;
      settings.gui.theme = T.lazygit.src // {
        lightTheme = false;
      };
    };
  };
}
