{ config, lib, pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./bat.nix
    ./mpv.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./silicon.nix
    ./neofetch.nix
    ./pfetch.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    ffmpeg
    fontpreview
    fortune
    gnupg
    libwebp
    lshw
    nurl
    nvtopPackages.full
    onefetch
    parallel
    playerctl
    scrcpy
    trash-cli
    tree
    unrar
    unzip
    zip
  ];

  programs = {
    thefuck.enable = true;
    zoxide.enable = true;
    yt-dlp.enable = true;
    jq.enable = true;
  };
}
