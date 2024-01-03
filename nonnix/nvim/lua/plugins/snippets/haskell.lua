local ls = require("luasnip")
local s, t = ls.snippet, ls.text_node

return {
  s("nixshell", {
    t({
      "#!/usr/bin/env nix-shell",
      "#!nix-shell --pure -i runghc",
      '#!nix-shell -p "haskellPackages.ghcWithPackages (pkgs: [ pkgs.turtle ])"',
    }),
  }),
}
