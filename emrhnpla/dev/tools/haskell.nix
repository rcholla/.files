{ config, lib, pkgs, usercfg, ... }:

{
  home = {
    packages = lib.optionals usercfg.misc.dev.tools.enable (with pkgs.haskellPackages; [
      cabal-install
      ghc
      ghcid
      haskell-debug-adapter
      haskell-language-server
      hlint
      hoogle
      ormolu
    ]);
    file.".ghc/ghci.conf".text = '':set prompt "λ "'';
  };
}
