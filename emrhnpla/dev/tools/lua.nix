{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    lua-language-server
    lua54Packages.lua
    lua54Packages.luacheck
    lua54Packages.luarocks
    stylua
  ];
}
