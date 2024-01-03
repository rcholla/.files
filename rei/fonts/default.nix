{ config, lib, pkgs, usercfg, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      usercfg.fonts.default.pkg
      usercfg.fonts.monospace.pkg
      (nerdfonts.override { fonts = [ "CascadiaCode" "Ubuntu" ]; })
    ];
    fontconfig.defaultFonts = {
      serif = [ usercfg.fonts.default.name "Ubuntu" ];
      sansSerif = [ usercfg.fonts.default.name "Ubuntu" ];
      monospace = [ usercfg.fonts.monospace.name "CascadiaCode" "Ubuntu" ];
    };
    fontDir.enable = true;
  };
}
