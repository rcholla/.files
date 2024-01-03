{ config, lib, pkgs, usercfg, ... }:

{
  home = {
    packages = lib.optionals usercfg.misc.dev.tools.enable (with pkgs; [
      cargo-expand
      cargo-watch
      rustup
      sqlx-cli
      vscode-extensions.vadimcn.vscode-lldb
    ]);
    sessionVariables.USERENV_DBG_CODELLDB = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb";
  };
}
