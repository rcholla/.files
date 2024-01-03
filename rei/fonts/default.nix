{ config, lib, pkgs, usercfg, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = usercfg.fonts.packages ++ [ (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" "Ubuntu" ]; }) ];
    fontconfig.defaultFonts = with usercfg.fonts; {
      serif = [ rubik.name "Ubuntu" ];
      sansSerif = [ rubik.name "Ubuntu" ];
      monospace = [
        firaCode.name
        mapleMono.name
        "CascadiaCode"
        "Ubuntu"
      ];
    };
    fontDir.enable = true;
  };
}
