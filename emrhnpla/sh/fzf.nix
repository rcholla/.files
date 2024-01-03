{ config, lib, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    colors = {
      "hl" = "#f38ba8";
      "hl+" = "#f38ba8";
      "fg" = "#cdd6f4";
      "fg+" = "#cdd6f4";
      "bg" = "#1e1e2e";
      "bg+" = "#313244";
      "info" = "#cba6f7";
      "prompt" = "#cba6f7";
      "spinner" = "#f5e0dc";
      "pointer" = "#f5e0dc";
      "header" = "#f38ba8";
      "marker" = "#f5e0dc";
    };
  };
}
