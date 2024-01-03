{ config, lib, pkgs, usercfg, ... }:
let
  T = usercfg.themes.default;
  userpkgs = {
    bin = with lib; {
      pidof = "${pkgs.sysvtools}/bin/pidof";
      hyprctl = "${pkgs.hyprland}/bin/hyprctl";
      brightnessctl = getExe pkgs.brightnessctl;
      hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
      systemctl = "${pkgs.systemd}/bin/systemctl";
      execWhenNoAudio = cmd: "${getExe userpkgs.execWhenNoAudio} '${cmd}'";
    };
    execWhenNoAudio = pkgs.writeShellApplication {
      name = "exec-when-no-audio";
      bashOptions = [ "nounset" "pipefail" ]; # Defaults without "errexit"
      runtimeInputs = with pkgs; [
        pipewire
        ripgrep
      ];
      text = ''
        cmd="$1"
        pw-cli i all | rg running -q
        if [ "$?" = "1" ]; then
          eval "$cmd"
        fi
      '';
    };
  };
in
{
  services.hypridle = with userpkgs.bin; {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pidof} ${hyprlock} || ${hyprlock}";
        before_sleep_cmd = hyprlock;
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
      };
      listener = [
        {
          timeout = 600;
          on-timeout = execWhenNoAudio "${brightnessctl} -s set 10";
          on-resume = execWhenNoAudio "${brightnessctl} -r";
        }
        {
          timeout = 3600;
          on-timeout = execWhenNoAudio hyprlock;
        }
        {
          timeout = 18000;
          on-timeout = execWhenNoAudio "${systemctl} suspend";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general.grace = 5;
      background = [{
        path = "screenshot";
        blur_passes = 3;
        blur_size = 2;
      }];
      input-field = [
        (T.hyprlock.src // {
          size = "275, 30";
          valign = "bottom";
          position = "0, 300";
          rounding = 0;
          outline_thickness = 1;
          shadow_size = 6;
          dots_size = 0.3;
          placeholder_text = "";
          fail_text = "<b>$FAIL</b>";
        })
      ];
      label = [{
        text = "<span size='42pt' fgcolor='##cba6f7'>$TIME</span><br/><span size='12pt' fgcolor='##b4befe'>$LAYOUT</span>";
        valign = "top";
        halign = "center";
        position = "0, -150";
        text_align = "center";
        font_family = usercfg.fonts.rubik.family;
      }];
    };
  };
}

