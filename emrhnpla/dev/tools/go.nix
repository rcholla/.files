{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      delve
      go
      gofumpt
      golangci-lint
      gopls
    ];
    sessionVariables = with pkgs; {
      GOPATH = "$HOME/.go";
      NVIM_DBG_DELVE = delve;
      NVIM_DBG_GO = "${vscode-extensions.golang.go}/share/vscode/extensions/golang.Go";
    };
  };
}
