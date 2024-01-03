{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs.haskellPackages; [
      cabal-install
      ghc
      ghci-dap
      haskell-dap
      haskell-debug-adapter
      haskell-language-server
      hlint
      hoogle
      ormolu
      stack
    ];
    sessionVariables.NVIM_DBG_HASKELL = pkgs.haskellPackages.haskell-debug-adapter;
    file.".ghc/ghci.conf".text = ''
      :set prompt "λ "
    '';
  };
}
