{ config, lib, pkgs, usercfg, ... }:

{
  home.packages = with pkgs; [ neofetch ];

  xdg.configFile."neofetch/config.conf".text = ''
    ##$ Neofetch Config;
    print_info() {
        prin "                                                                               "
        prin "''${cl7}┌─────────────────\n ''${cl4}Hardware Information''${cl7} \n────────────────┐"
        info " ​ ​ 󰌢 " model
        info " ​ ​ 󰍹 " resolution
        info " ​ ​ 󰍛 " cpu
        info " ​ ​ ﬙ " gpu
        info " ​ ​  " memory
        prin "''${cl7}├─────────────────\n ''${cl4}Software Information''${cl7} \n────────────────┤"
        info " ​ ​  " kernel
        info " ​ ​  " distro
        info " ​ ​  " de
        info " ​ ​  " shell
        info " ​ ​  " term
        info " ​ ​  " packages 
        info " ​ ​ ﮫ " uptime
        prin "''${cl7}└───────────────────────────────────────────────────────┘"
        info cols
    prin "\n \n \n \n \n \n \n \n \n \n \n \n \n \n ''${cl3} \n \n ''${cl5} \n \n ''${cl2} \n \n ''${cl6} \n \n ''${cl4} \n \n ''${cl1} \n \n ''${cl7} \n \n ''${cl0}"
    }
    ## Options;
    # Colors;
    magenta="\033[1;35m"
    green="\033[1;32m"
    white="\033[1;37m"
    blue="\033[1;34m"
    red="\033[1;31m"
    black="\033[1;40;30m"
    yellow="\033[1;33m"
    cyan="\033[1;36m"
    reset="\033[0m"
    bgyellow="\033[1;43;33m"
    bgwhite="\033[1;47;37m"
    cl0="''${reset}"
    cl1="''${magenta}"
    cl2="''${green}"
    cl3="''${white}"
    cl4="''${blue}"
    cl5="''${red}"
    cl6="''${yellow}"
    cl7="''${cyan}"
    cl8="''${black}"
    cl9="''${bgyellow}"
    cl10="''${bgwhite}"
    # Kernel;
    kernel_shorthand="off"
    # Distro;
    distro_shorthand="on"
    os_arch="off"
    # Memory;
    memory_percent="on"
    # Packages;
    package_managers="on"
    # Shell;
    shell_path="off"
    shell_version="on"
    # CPU;
    cpu_brand="on"
    cpu_speed="off"
    cpu_cores="logical"
    cpu_temp="off"
    # GPU;
    gpu_brand="on"
    gpu_type="all"
    # Resolution;
    refresh_rate="on"
    # Separator;
    separator="  "
    # Color Blocks;
    color_blocks="off"
    # Backend;
    image_backend="kitty"
    image_source="${usercfg.dir.dotfiles.assets}/nwixowos.png"
    # Image;
    image_size="275px"
    image_loop="off"
    gap=2
    ##$;
  '';
}
