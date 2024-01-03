{
  description = "One flake to rule them all.";

  nixConfig = {
    extra-substituters = [
      "https://devenv.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      usercfg = rec {
        system = "x86_64-linux";
        protocol = "wayland";
        host = "common";
        hostname = "rei";
        username = "emrhnpla";
        fullname = "Emirhan Pala";
        email = "emrhnpla02@proton.me";
        wallpapers = rec {
          getPath = name: type: "${dir.dotfiles.wallpapers}/${type}/${name}.${type}";
          desktop = rec { name = "rei"; path = type: getPath name type; };
          lockscreen = rec { name = "glow-tree"; path = type: getPath name type; };
        };
        locale = {
          layout = "us";
          timezone = "Europe/Istanbul";
          i18n = { default = "en_US.UTF-8"; extra = "tr_TR.UTF-8"; };
        };
        fonts = with pkgs; {
          default = rec { name = "Rubik"; family = name; pkg = rubik; };
          monospace = rec { name = "FiraCode"; family = "FiraCode Nerd Font Mono"; pkg = nerdfonts.override { fonts = [ name ]; }; };
        };
        dir = rec {
          home = "/home/${username}";
          dotfiles = rec {
            self = "${home}/.files";
            assets = "${self}/assets";
            wallpapers = "${assets}/wallpapers";
          };
          all = rec {
            self = "${home}/All";
            repos = "${self}/Repos";
            notes = "${self}/Notes";
          };
        };
        env = with pkgs; {
          browser = { name = "firefox-developer-edition"; pkg = firefox-devedition-bin; };
          editor = { name = "nvim"; pkg = neovim-nightly; };
          terminal = { name = "kitty"; pkg = kitty; };
          shell = { name = "zsh"; pkg = zsh; };
        };
        misc = {
          sops = rec {
            enable = true;
            password = "${username}-password";
            secrets = {
              ${password}.neededForUsers = true;
              obsidian-rest-api-key.owner = username;
            };
          };
          syncthing = {
            enable = true;
            dataDir = "${dir.home}/Syncthing";
            settings = rec {
              devices.reidroid = {
                name = "reidroid";
                id = "ZJ2XTIB-QKKH5L4-PB7CWJA-ERRKQXG-E3S2ZYL-YNFHX2R-M2YZ77B-VKINNQZ";
              };
              folders.All = {
                path = dir.all.self;
                devices = [ devices.reidroid.name ];
              };
            };
          };
        };
      };
      pkgs = import nixpkgs {
        inherit (usercfg) system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        overlays = [ inputs.neovim-nightly-overlay.overlay ];
      };
    in
    {
      devShell.${usercfg.system} = inputs.devenv.lib.mkShell {
        inherit pkgs inputs;
        modules = [ ./shell.nix ];
      };

      nixosConfigurations.${usercfg.hostname} = nixpkgs.lib.nixosSystem {
        inherit (usercfg) system;
        inherit pkgs;
        specialArgs = { inherit inputs usercfg; };
        modules = [ (./. + "/${usercfg.hostname}/configuration.nix") ];
      };

      homeConfigurations.${usercfg.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs usercfg; };
        modules = [ (./. + "/${usercfg.username}/home.nix") ];
      };
    };
}
