{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    sqlfluff
    sqls
  ];
}
