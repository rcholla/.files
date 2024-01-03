{ config, lib, pkgs, usercfg, ... }:
let
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
    c = "clear";
    q = "exit";
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
        rev = "master";
        hash = "sha256-6ygs7XcKaqxDhfXdEgEbVVSnlEMcACXjRX4JrLzPUJY=";
      };
    }
    {
      name = "vim";
      src = pkgs.fetchFromGitHub {
        owner = "zap-zsh";
        repo = "vim";
        rev = "master";
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

    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
    typeset -gA ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[comment]="fg=#585b70"
    ZSH_HIGHLIGHT_STYLES[alias]="fg=#a6e3a1"
    ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=#a6e3a1"
    ZSH_HIGHLIGHT_STYLES[global-alias]="fg=#a6e3a1"
    ZSH_HIGHLIGHT_STYLES[function]="fg=#a6e3a1"
    ZSH_HIGHLIGHT_STYLES[command]="fg=#a6e3a1"
    ZSH_HIGHLIGHT_STYLES[precommand]="fg=#a6e3a1,italic"
    ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=#fab387,italic"
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=#fab387"
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=#fab387"
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=#cba6f7"
    ZSH_HIGHLIGHT_STYLES[builtin]="fg=#a6e3a1"
    ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=#a6e3a1"
    ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=#a6e3a1"
    ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=#f38ba8"
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="fg=#f38ba8"
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=#f38ba8"
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=#f38ba8"
    ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]="fg=#f9e2af"
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]="fg=#f9e2af"
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=#f9e2af"
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]="fg=#f38ba8"
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=#f9e2af"
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]="fg=#f38ba8"
    ZSH_HIGHLIGHT_STYLES[rc-quote]="fg=#f9e2af"
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]="fg=#f38ba8"
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[assign]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[named-fd]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[numeric-fd]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=#f38ba8"
    ZSH_HIGHLIGHT_STYLES[path]="fg=#cdd6f4,underline"
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=#cdd6f4,underline"
    ZSH_HIGHLIGHT_STYLES[path_prefix]="fg=#cdd6f4,underline"
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]="fg=##cdd6f4,underline"
    ZSH_HIGHLIGHT_STYLES[globbing]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=#cba6f7"
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]="fg=#f38ba8"
    ZSH_HIGHLIGHT_STYLES[redirection]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[arg0]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[default]="fg=#cdd6f4"
    ZSH_HIGHLIGHT_STYLES[cursor]="fg=#cdd6f4"
  '';
  initExtra = ''
    autoload -Uz vcs_info
    autoload -U colors && colors

    precmd_vcs_info() { vcs_info; }
    precmd_functions+=(precmd_vcs_info)
    +vi-git-untracked() {
      if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]] &&
        git status --porcelain | grep "??" &>/dev/null; then
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
