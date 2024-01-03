{ config, lib, pkgs, usercfg, ... }:

{
  home.packages = lib.optionals usercfg.misc.dev.tools.enable (with pkgs; [
    emmet-language-server
    eslint_d
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
    nodejs
    prettierd
    tailwindcss-language-server
    vscode-extensions.firefox-devtools.vscode-firefox-debug
    vscode-langservers-extracted
    yarn
  ]);

  programs.bun = {
    enable = true;
    settings.telemetry = false;
  };
}
