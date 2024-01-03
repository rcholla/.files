{ config, lib, pkgs, ... }:

{
  imports = [
    ./nvim.nix
    ./tools/nix.nix
    ./tools/bash.nix
    ./tools/lua.nix
    ./tools/node.nix
    ./tools/yaml.nix
    ./tools/toml.nix
    ./tools/markdown.nix
    ./tools/go.nix
    ./tools/rust.nix
    ./tools/haskell.nix
    ./tools/sql.nix
  ];
}
