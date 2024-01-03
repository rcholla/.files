{ config, lib, pkgs, usercfg, ... }:

{
  home.packages = lib.optionals usercfg.misc.dev.tools.enable (with pkgs; [
    lua-language-server
    lua54Packages.lua
    lua54Packages.luacheck
    lua54Packages.luarocks
    stylua
  ]);
}
