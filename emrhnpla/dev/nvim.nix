{ config, lib, pkgs, inputs, usercfg, ... }:
let
  userpkgs = rec {
    nvim-no-padding = pkgs.writeShellApplication {
      name = "nvim-no-padding";
      runtimeInputs = with pkgs; [
        kitty
        neovim
      ];
      text = ''
        kitty @ set-spacing padding=0
        if [ -n "$*" ]; then
          nvim "$*"
        else
          nvim
        fi
        kitty @ set-spacing padding=default
      '';
    };
    nvim-fzf = pkgs.writeShellApplication {
      name = "nvim-fzf";
      runtimeInputs = with pkgs; [
        findutils
        fzf
      ];
      text = ''
        function _ffind_repos { find "$1" -name .git -type d -exec dirname {} \; | fzf; }

        ${lib.getExe nvim-no-padding} "$(_ffind_repos "''${1:-$HOME}")"
      '';
    };
  };
in
{
  home = {
    packages = with pkgs; [
      chafa
      fd
      ffmpegthumbnailer
      graphviz
      haskellPackages.fast-tags
      manix
      ripgrep
      tree-sitter
      userpkgs.nvim-fzf
      userpkgs.nvim-no-padding
    ];
    sessionVariables.USERENV_OBSIDIAN_DIR = usercfg.dir.all.notes;
  };

  xdg.configFile."nvim/" = {
    source = ../../nonnix/nvim;
    recursive = true;
  };

  programs = {
    neovim = {
      enable = true;
      package = usercfg.env.editor.pkg;
      defaultEditor = true;
    };
    kitty.keybindings."ctrl+space" = "send_text normal ${lib.getExe userpkgs.nvim-fzf} ${usercfg.dir.all.repos}\\r";
    zsh = {
      shellAliases = with lib; with userpkgs; {
        sv = "sudo -E ${getExe nvim-no-padding}";
        vf = getExe nvim-fzf;
        v = getExe nvim-no-padding;
      };
      initExtra = lib.mkIf usercfg.misc.other.sops.enable ''
        if [[ -o interactive ]]; then
          export OBSIDIAN_REST_API_KEY=$(cat /run/secrets/obsidian-rest-api-key)
        fi
      '';
    };
  };
}
