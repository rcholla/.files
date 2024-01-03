{ config, lib, pkgs, usercfg, ... }:

{
  home = {
    packages = with pkgs; [
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
    ];
    sessionVariables = with pkgs; {
      NVIM_DBG_FIREFOX = "${vscode-extensions.firefox-devtools.vscode-firefox-debug}/share/vscode/extensions/firefox-devtools.vscode-firefox-debug";
      NVIM_FIREFOX_EXECUTABLE = "${firefox-devedition-bin}/bin/firefox-developer-edition"; # NOTE: i'm not happy about this
    };
  };
}
