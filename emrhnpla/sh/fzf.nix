{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
in
{
  programs.fzf = {
    enable = true;
    defaultCommand = "${lib.getExe pkgs.fd} --type f --strip-cwd-prefix";
    colors = T.fzf.src;
  };
}
