{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
  shellAliases = {
    ## Folders;
    dotfiles = "z ${usercfg.dir.dotfiles.self}";
    repos = "z ${usercfg.dir.all.repos}";
    notes = "z ${usercfg.dir.all.notes}";
    ## Rename;
    bc = "bluetoothctl";
    lg = "lazygit";
    d = "dolphin";
    pls = "doas";
    ## Utils;
    # Nix;
    ownix = "doas chown ${usercfg.username}:users $XDG_CACHE_HOME/nix/eval-cache-v5/*";
    home-manager = "ownix && home-manager";
    # Gpg;
    enc = "gpg -c --no-symkey-cache --cipher-algo AES256 -c --no-symkey-cache=symmetric";
    dec = "gpg -d";
    # Grep;
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
    grep = "grep --color=auto";
    # Ls;
    ls = "ls --color";
    sl = "ls --color";
  };
  plugins = [
    {
      name = "supercharge";
      src = pkgs.fetchFromGitHub {
        owner = "zap-zsh";
        repo = "supercharge";
        rev = "e76f4e82d443706c2d9c8ab8e9633facbcdec768";
        hash = "sha256-6ygs7XcKaqxDhfXdEgEbVVSnlEMcACXjRX4JrLzPUJY=";
      };
    }
    {
      name = "vim";
      src = pkgs.fetchFromGitHub {
        owner = "zap-zsh";
        repo = "vim";
        rev = "46284178bcad362db40509e1db058fe78844d113";
        hash = "sha256-aAmbl5XT0gj/obEVznc7M0DkyWmyRNSyO/QPwMqzZ00=";
      };
    }
    {
      name = "zsh-autopair";
      src = pkgs.fetchFromGitHub {
        owner = "hlissner";
        repo = "zsh-autopair";
        rev = "v1.0";
        hash = "sha256-wd/6x2p5QOSFqWYgQ1BTYBUGNR06Pr2viGjV/JqoG8A=";
      };
    }
    {
      name = "zsh-autosuggestions";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-autosuggestions";
        rev = "v0.7.0";
        hash = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
      };
    }
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-syntax-highlighting";
        rev = "0.7.1";
        hash = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
      };
    }
    {
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.8.0";
        hash = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
      };
    }
  ];
  initExtraFirst = ''
    setopt APPENDHISTORY AUTOCD NOMATCH MENUCOMPLETE INTERACTIVE_COMMENTS PROMPT_SUBST
    unsetopt BEEP

    source ${T.zsh-syntax-highlighing.path}
  '';
  initExtra = ''
    autoload -Uz vcs_info
    autoload -U colors && colors

    precmd_vcs_info() { vcs_info; }
    precmd_functions+=(precmd_vcs_info)
    +vi-git-untracked() {
      if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) = "true" ]] && git status --porcelain | grep "??" &>/dev/null; then
        hook_com[staged]+="!"
      fi
    }

    zstyle ":vcs_info:*" enable git
    zstyle ":vcs_info:*" check-for-changes true
    zstyle ":vcs_info:git*+set-message:*" hooks git-untracked
    zstyle ":vcs_info:git:*" formats " %{''${fg[blue]}%}(%{''${fg[red]}%}%m%u%c%{''${fg[yellow]}%}%{''${fg[magenta]}%} %b%{''${fg[blue]}%})"

    PROMPT="%B%{''${fg[blue]}%}[%{''${fg[white]}%}%n%{''${fg[red]}%}@%{''${fg[white]}%}%m%{''${fg[blue]}%}] %(?:%{''${fg_bold[green]}%}➜ :%{''${fg_bold[red]}%}➜ )%{''${fg[cyan]}%}%c%{$reset_color%}"
    PROMPT+="\$vcs_info_msg_0_ "
  '';
in
{
  programs.zsh = {
    enable = true;
    package = usercfg.env.shell.pkg;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    inherit shellAliases plugins initExtraFirst initExtra;
  };
}
