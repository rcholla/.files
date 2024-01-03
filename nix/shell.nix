{ config, lib, pkgs, ... }:

{
  name = ".files";

  languages = {
    nix.enable = true;
    lua = {
      enable = true;
      package = pkgs.lua51Packages.lua;
    };
  };

  pre-commit.hooks = {
    nixpkgs-fmt.enable = true;
    statix.enable = true;
    stylua.enable = true;
    luacheck.enable = true;
  };

  packages = with pkgs; [ yaml-language-server ];

  enterShell = ''
    output="
         (         (           
         )\ )  (   )\   (      
        (()/(  )\ ((_) ))\ (   
         /(_))((_) _  /((_))\  
        (_) _| (_)| |(_)) ((_) 
       _ |  _| | || |/ -_)(_-< 
      (_)|_|   |_||_|\___|/__/ 
    "
    echo "$output" | ${pkgs.lolcat}/bin/lolcat
  '';
}
