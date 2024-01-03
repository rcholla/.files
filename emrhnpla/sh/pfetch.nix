{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [ pfetch ];
    sessionVariables = {
      PF_INFO = "ascii title os kernel uptime pkgs palette";
      PF_ALIGN = "8";
      PF_SEP = "";
    };
  };

  programs.zsh.initExtra = "pfetch";
}
