# installation notes for myself

```bash
# the following command will execute the `dotfiles-pre-build` script defined in 'nix/pre-build.nix'
# which will perform the following steps in order:
#   1- clone the repository to the path specified with `usercfg.dir.dotfiles.self`, if it doesn't exist
#   2- vim into 'flake.nix'
#   3- generate a hardware configuration file using `nixos-generate-config` under the '$HOME/.files' directory
# after running this command, you will probably need to update hardware-related configuration files such as:
#   - rei/hardware/common/kernel.nix
#   - rei/hardware/common/filesystem.nix
#   - rei/hardware/common/bootloader.nix
# and if `usercfg.misc.other.sops.enable` is set to `true`, you need to make sure that:
#   - `usercfg.misc.other.sops.sshPath` is a valid path to your ssh key
#   - `usercfg.misc.other.sops.secrets` matches `secrets/secrets.yaml`
#   - age key is defined in the '.sops.yaml' file
# and lastly, if `usercfg.misc.other.syncthing.enable` is set to `true`, you need to make sure that:
#   - `usercfg.misc.other.syncthing.settings` is defined as you want it to be
# Note that; by default, all `usercfg.misc.**.enable` options are set to `true`
# since 'flake.nix' does not get modified by `dotfiles-pre-build` script *yet*
nix run github:rcholla/.files

# the following command will execute the `dotfiles-build` script defined in 'nix/build.nix'
# which will just build the whole system using `nixos-rebuild` and `nix run home-manager/master`
nix run github:rcholla/.files#build
```
