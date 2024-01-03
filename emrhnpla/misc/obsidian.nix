{ config, lib, pkgs, ... }:
let
  userpkgs.install-or-update-obsidian = pkgs.writeShellApplication {
    name = "install-or-update-obsidian";
    text = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      flatpak install --or-update flathub md.obsidian.Obsidian
    '';
  };
in
{
  home.packages = [ userpkgs.install-or-update-obsidian ];

  programs.zsh.shellAliases.obsidian = "${userpkgs.install-or-update-obsidian.name} && flatpak run md.obsidian.Obsidian";
}
