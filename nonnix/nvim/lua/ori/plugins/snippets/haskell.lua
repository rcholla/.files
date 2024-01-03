local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("nixshell", {
    t({
      "#!/usr/bin/env nix-shell",
      "#!nix-shell --pure -i runghc",
      '#!nix-shell -p "haskellPackages.ghcWithPackages (pkgs: [ pkgs.turtle ])"',
    }),
  }),
}
