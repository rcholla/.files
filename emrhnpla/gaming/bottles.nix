{ config, lib, pkgs, ... }:
let
  userpkgs.install-or-update-bottles = pkgs.writeShellApplication {
    name = "install-or-update-bottles";
    text = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      flatpak install --or-update flathub com.usebottles.bottles
    '';
  };
in
{
  home.packages = [ userpkgs.install-or-update-bottles ];

  programs.zsh.shellAliases.bottles = "${userpkgs.install-or-update-bottles.name} && flatpak run com.usebottles.bottles";
}
