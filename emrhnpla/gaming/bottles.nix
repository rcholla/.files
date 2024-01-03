{ config, lib, pkgs, ... }:
let
  userpkgs.install-or-update-bottles = pkgs.writeShellApplication {
    name = "install-or-update-bottles";
    runtimeInputs = with pkgs; [ flatpak ];
    text = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      flatpak install --or-update flathub com.usebottles.bottles
    '';
  };
in
{
  home.packages = [ userpkgs.install-or-update-bottles ];

  programs.zsh.shellAliases.bottles = "${lib.getExe userpkgs.install-or-update-bottles} && flatpak run com.usebottles.bottles";
}
