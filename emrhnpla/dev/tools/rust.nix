{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      cargo-expand
      cargo-watch
      rustup
      sqlx-cli
      vscode-extensions.vadimcn.vscode-lldb
    ];
    sessionVariables.NVIM_DBG_CODELLDB = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb";
  };
}
