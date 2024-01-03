local util = require("lspconfig/util")

return {
  root_dir = util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts"
  ),
}
