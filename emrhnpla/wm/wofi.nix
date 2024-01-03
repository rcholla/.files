{ config, lib, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      key_up = "Control_L-k";
      key_down = "Control_L-j";
    };
    style = ''
      window {
        margin: 5px;
        background-color: rgba(30, 30, 46, 0.9);
        border: 1px solid #89b4fa;
      }

      #input {
        margin: 5px;
        background-color: rgba(24, 24, 37, 0.9);
        border: 1px solid rgb(49 50 68, 0.9);
        font-weight: bold;
        color: #cdd6f4;
      }

      #scroll {
        margin: 5px;
      }

      #entry:selected {
        background-color: rgb(137 180 250, 0.9);
      }

      #text {
        margin: 5px;
        font-weight: bold;
        color: #cdd6f4;
      }
      #text:selected {
        color: rgb(17 17 27, 0.9);
      }
    '';
  };
}
