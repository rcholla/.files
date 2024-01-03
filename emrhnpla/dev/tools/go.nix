{ config, lib, pkgs, usercfg, ... }:

{
  home = {
    packages = lib.optionals usercfg.misc.dev.tools.enable (with pkgs; [
      delve
      go
      gofumpt
      golangci-lint
      gopls
    ]);
    sessionVariables.GOPATH = "$HOME/.go";
  };
}
