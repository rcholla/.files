{ pkgs, inputs }:
let
  inherit (pkgs) lib;
in
rec {
  bat = rec {
    name = "CatppuccinMocha";
    file = "themes/Catppuccin Mocha.tmTheme";
    path = "${src}/${file}";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "bat";
      rev = "b19bea35a85a32294ac4732cad5b0dc6495bed32";
      hash = "sha256-POoW2sEM6jiymbb+W/9DKIjDM1Buu1HAmrNP0yC2JPg=";
    };
  };

  btop = rec {
    name = "CatppuccinMocha";
    file = "themes/catppuccin_mocha.theme";
    path = "${src}/${file}";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "btop";
      rev = "1.0.0";
      hash = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
    };
  };

  cava.src = {
    gradient = 1;
    gradient_color_1 = "'#94e2d5'";
    gradient_color_2 = "'#89dceb'";
    gradient_color_3 = "'#74c7ec'";
    gradient_color_4 = "'#89b4fa'";
    gradient_color_5 = "'#cba6f7'";
    gradient_color_6 = "'#f5c2e7'";
    gradient_color_7 = "'#eba0ac'";
    gradient_color_8 = "'#f38ba8'";
  };

  cursor = {
    name = "catppuccin-mocha-dark-cursors";
    src = pkgs.catppuccin-cursors.mochaDark;
  };

  dunst.src = {
    global.frame_color = "#89B4FA";
    urgency = {
      urgency_low = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
      };
      urgency_normal = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
      };
      urgency_critical = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#FAB387";
      };
    };
  };

  fzf.src = {
    "bg" = "#1e1e2e";
    "bg+" = "#313244";
    "fg" = "#cdd6f4";
    "fg+" = "#cdd6f4";
    "header" = "#f38ba8";
    "hl" = "#f38ba8";
    "hl+" = "#f38ba8";
    "info" = "#cba6f7";
    "marker" = "#f5e0dc";
    "pointer" = "#f5e0dc";
    "prompt" = "#cba6f7";
    "spinner" = "#f5e0dc";
  };

  gtk = {
    name = "catppuccin-mocha-blue-standard+normal";
    src = pkgs.catppuccin-gtk.override {
      variant = "mocha";
      accents = [ "blue" ];
      size = "standard";
      tweaks = [ "normal" ];
    };
  };

  hyprland = {
    name = "CatppuccinMocha";
    src = ../../nonnix/themes/catppuccin/hyprland.conf;
  };

  hyprlock.src = {
    check_color = "rgb(17, 17, 27)";
    fail_color = "rgb(17, 17, 27)";
    font_color = "rgb(17, 17, 27)";
    inner_color = "rgb(203, 166, 247)";
    shadow_color = "rgb(17, 17, 27)";
  };

  icons = {
    name = "Papirus-Dark";
    src = pkgs.papirus-icon-theme.override { color = "blue"; };
  };

  kitty.name = "Catppuccin-Mocha";

  lazygit.src = {
    activeBorderColor = [ "#89b4fa" "bold" ];
    inactiveBorderColor = [ "#a6adc8" ];
    optionsTextColor = [ "#89b4fa" ];
    selectedLineBgColor = [ "#313244" ];
    cherryPickedCommitBgColor = [ "#45475a" ];
    cherryPickedCommitFgColor = [ "#89b4fa" ];
    unstagedChangesColor = [ "#f38ba8" ];
    defaultFgColor = [ "#cdd6f4" ];
    searchingActiveBorderColor = [ "#f9e2af" ];
    authorColors."*" = "#b4befe";
  };

  qt = {
    name = "Catppuccin-Mocha-Blue";
    src = pkgs.catppuccin-kvantum.override {
      variant = "Mocha";
      accent = "Blue";
    };
  };

  silicon = bat;

  spicetify = {
    name = "mocha";
    src = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
  };

  vencord = {
    name = "CatppuccinMocha";
    src = ''
      /**
       * @name Catppuccin Mocha
       * @author winston#0001
       * @authorId 505490445468696576
       * @version 0.2.0
       * @description 🎮 Soothing pastel theme for Discord
       * @website https://github.com/catppuccin/discord
       * **/

      @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
    '';
  };

  waybar = {
    name = "CatppuccinMocha";
    src = ../../nonnix/themes/catppuccin/waybar.css;
  };

  yazi = rec {
    file = "/themes/mocha.toml";
    path = "${src}/${file}";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "yazi";
      rev = "37dec9bf1f7e52e0d593c225827b9dbc71ce504c";
      hash = "sha256-oJo52hMSK7mr5f0DtnyaN1FVOSKKUOHWCT80V1qfyrU=";
    };
  };

  zsh-syntax-highlighing = rec {
    file = "/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
    path = "${src}/${file}";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "zsh-syntax-highlighting";
      rev = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
      hash = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
    };
  };
}
