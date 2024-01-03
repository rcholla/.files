{ config, lib, pkgs, usercfg, ... }:

{
  home.packages = lib.optionals usercfg.misc.dev.tools.enable (with pkgs; [
    nodePackages.bash-language-server
    shellcheck
    shfmt
  ]);
}
