{ usercfg
, writeShellApplication
, git
, nix
, sudo
}:

writeShellApplication {
  name = "dotfiles-build";

  runtimeInputs = [
    git
    nix
    sudo
  ];

  text = ''
    dotfiles_dir="${usercfg.dir.dotfiles.self}"

    sudo nixos-rebuild switch --flake "$dotfiles_dir#${usercfg.hostname}"

    nix run home-manager/master switch --extra-experimental-features "nix-command flakes" -- --flake "$dotfiles_dir#${usercfg.username}" -b backup
  '';
}

