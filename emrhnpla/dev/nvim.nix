{ config, lib, pkgs, inputs, usercfg, ... }:
let
  userpkgs = rec {
    nvim-no-padding = pkgs.writeShellApplication {
      name = "nvim-no-padding";
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
      text = ''
        function _ffind_repos { find "$1" -name .git -type d -exec dirname {} \; | fzf; }

        ${nvim-no-padding.name} "$(_ffind_repos "''${1:-$HOME}")"
      '';
    };
  };
in
{
  home = {
    packages = [
      userpkgs.nvim-no-padding
      userpkgs.nvim-fzf
    ];
    sessionVariables.NVIM_OBSIDIAN_DIR = usercfg.dir.all.notes;
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
      extraPackages = with pkgs; [
        fd
        graphviz
        haskellPackages.fast-tags
        imagemagick
        manix
        ripgrep
        tree-sitter
      ];
      extraLuaPackages = luaPkgs: with luaPkgs; [ magick ];
    };
    kitty.keybindings."ctrl+space" = "send_text normal vf ${usercfg.dir.all.repos}\\r";
    zsh = {
      shellAliases = with userpkgs; {
        vf = nvim-fzf.name;
        sv = "sudo -E ${nvim-no-padding.name}";
        v = nvim-no-padding.name;
      };
      initExtra = ''
        if [[ -o interactive ]]; then
          export OBSIDIAN_REST_API_KEY=$(cat /run/secrets/obsidian-rest-api-key)
        fi
      '';
    };
  };
}
