{ config, lib, pkgs, inputs, usercfg, ... }:
let
  userpkgs = {
    exe = {
      nvim-fzf-exe = lib.getExe userpkgs.nvim-fzf;
      nvim-no-padding-exe = lib.getExe userpkgs.nvim-no-padding;
    };
    nvim-fzf = pkgs.writeShellApplication {
      name = "nvim-fzf";
      runtimeInputs = with pkgs; [
        findutils
        fzf
      ];
      text = ''
        fzf_result=$(fzf --multi --preview "bat --color 'always' {}")
        if [ -n "$fzf_result" ]; then
           ${lib.getExe userpkgs.nvim-no-padding} "$fzf_result"
        fi
      '';
    };
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
      lua51Packages.luarocks
      manix
      ripgrep
      tree-sitter
      userpkgs.nvim-fzf
      userpkgs.nvim-no-padding
    ];
    sessionVariables = {
      USERENV_OBSIDIAN_DIR = usercfg.dir.all.notes;
      USERENV_NVIM_LOCKFILE_DIR = "${usercfg.dir.dotfiles.self}/nonnix/nvim/lazy-lock.json";
    };
  };

  xdg.configFile."nvim/" = {
    source = ../../nonnix/nvim;
    recursive = true;
  };

  programs = with userpkgs.exe; {
    neovim = {
      enable = true;
      package = usercfg.env.editor.pkg;
      defaultEditor = true;
    };
    zsh = {
      shellAliases = {
        sv = "sudo -E ${nvim-no-padding-exe}";
        v = nvim-no-padding-exe;
        vf = nvim-fzf-exe;
      };
      initExtra = lib.mkIf usercfg.misc.other.sops.enable ''
        if [[ -o interactive ]]; then
          export OBSIDIAN_REST_API_KEY=$(cat /run/secrets/obsidian-rest-api-key)
        fi
      '';
    };
    kitty.keybindings."ctrl+space" = "send_text normal ${nvim-fzf-exe}\\r";
  };
}
