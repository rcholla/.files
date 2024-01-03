{ config, pkgs, ... }:

{
  name = ".files";

  languages.nix.enable = true;

  pre-commit.hooks = {
    nixpkgs-fmt.enable = true;
    statix.enable = true;
    stylua.enable = true;
    luacheck.enable = true;
  };

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
