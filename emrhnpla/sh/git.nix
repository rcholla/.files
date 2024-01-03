{ config, lib, pkgs, usercfg, ... }:

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
        pull.rebase = true;
      };
      lfs.enable = true;
    };
    lazygit = {
      enable = true;
      settings.gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "#a6e3a1" "bold" ];
        inactiveBorderColor = [ "#cdd6f4" ];
        optionsTextColor = [ "#89b4fa" ];
        selectedLineBgColor = [ "#313244" ];
        selectedRangeBgColor = [ "#313244" ];
        cherryPickedCommitBgColor = [ "#94e2d5" ];
        cherryPickedCommitFgColor = [ "#89b4fa" ];
        unstagedChangesColor = [ "red" ];
      };
    };
  };
}
