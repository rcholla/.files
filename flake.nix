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
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    let
      usercfg = rec {
        system = "x86_64-linux";
        protocol = "wayland";
        host = "common";
        hostname = "rei";
        username = "emrhnpla";
        fullname = "Emirhan Pala";
        email = "emrhnpla02@proton.me";
        themes = rec {
          default = catppuccin;
          catppuccin = import ./nix/themes/catppuccin.nix { inherit pkgs inputs; };
        };
        wallpapers = rec {
          pathOf = name: type: "${dir.dotfiles.wallpapers}/${type}/${name}.${type}";
          desktop = rec { name = "rei"; path = pathOf name "mp4"; };
        };
        locale = {
          layout = "us";
          timezone = "Europe/Istanbul";
          i18n = { default = "en_US.UTF-8"; extra = "tr_TR.UTF-8"; };
        };
        fonts = rec {
          packages = [ rubik.pkg firaCode.pkg mapleMono.pkg ];
          rubik = rec {
            name = "Rubik";
            family = name;
            pkg = pkgs.rubik;
          };
          firaCode = rec {
            name = "FiraCode";
            family = "FiraCode Nerd Font Mono";
            pkg = pkgs.nerdfonts.override { fonts = [ name ]; };
            variants = {
              regular = "${family} Reg";
              medium = "${family} Med";
              bold = "${family} Bold";
            };
          };
          mapleMono = rec {
            name = "Maple Mono";
            family = "Maple Mono NF";
            pkg = pkgs.maple-mono-NF;
            variants = {
              regular = "${family} Regular";
              bold = "${family} Bold";
              italic = "${family} Italic";
              boldItalic = "${family} BoldItalic";
            };
          };
        };
        dir = rec {
          home = "/home/${username}";
          dotfiles = rec {
            self = "${home}/.files";
            assets = "${self}/assets";
            wallpapers = "${assets}/wallpapers";
            neovim = "${self}/nonnix/nvim";
          };
          all = rec {
            self = "${home}/All";
            repos = "${self}/repos";
            notes = "${self}/notes";
          };
        };
        env = {
          browser = { name = "firefox"; pkg = pkgs.firefox; };
          editor = { name = "nvim"; pkg = pkgs.neovim; };
          terminal = { name = "kitty"; pkg = pkgs.kitty; };
          shell = { name = "zsh"; pkg = pkgs.zsh; };
        };
        misc = {
          audio = {
            enable = true;
            musnix.enable = true;
          };
          dev = {
            enable = true;
            tools.enable = false;
          };
          gaming = {
            enable = true;
            steam.enable = true;
            bottles.enable = true;
            gamemode.enable = true;
            mangohud.enable = true;
          };
          other = {
            piper.enable = true;
            postgres.enable = true;
            virt-manager.enable = true;
            sops = rec {
              enable = true;
              sshPath = "${dir.home}/.ssh/id_ed25519";
              names.password = "${username}-password";
              secrets = {
                ${names.password}.neededForUsers = true;
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
      };
      pkgs = import inputs.nixpkgs {
        inherit (usercfg) system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        overlays = with inputs; [ neovim-nightly-overlay.overlays.default ];
      };
    in
    {
      formatter.${usercfg.system} = pkgs.nixpkgs-fmt;

      devShells.${usercfg.system}.default = inputs.devenv.lib.mkShell {
        inherit pkgs inputs;
        modules = [ ./nix/shell.nix ];
      };

      packages.${usercfg.system} = rec {
        default = pre-build;
        pre-build = pkgs.callPackage ./nix/pre-build.nix { inherit usercfg; };
        build = pkgs.callPackage ./nix/build.nix { inherit usercfg; };
      };

      nixosConfigurations.${usercfg.hostname} = inputs.nixpkgs.lib.nixosSystem {
        inherit (usercfg) system;
        inherit pkgs;
        specialArgs = { inherit inputs usercfg; };
        modules = [ (./. + "/${usercfg.hostname}/configuration.nix") ];
      };

      homeConfigurations.${usercfg.username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs usercfg; };
        modules = [ (./. + "/${usercfg.username}/home.nix") ];
      };
    };
}
