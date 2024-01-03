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
    ./yazi.nix
    ./comma.nix
    ./direnv.nix
    ./silicon.nix
  ];

  home.packages = with pkgs; [
    ani-cli
    brightnessctl
    ffmpeg
    fontpreview
    fortune
    gnupg
    imagemagick
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
    ripgrep.enable = true;
    zoxide.enable = true;
    yt-dlp.enable = true;
    fd.enable = true;
    jq.enable = true;
  };
}
