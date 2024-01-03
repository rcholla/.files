require("ori.core")
require("ori.lazy-manager").install_and_then(("%s/lazy/lazy.nvim"):format(vim.fn.stdpath("data")), {
  spec = {
    { import = "ori.plugins.colorschemes" },
    { import = "ori.plugins" },
    { import = "ori.plugins.lang" },
    { import = "ori.plugins.tool" },
  },
  ui = {
    border = "rounded",
  },
  lockfile = ("%s/lazy-lock.json"):format(os.getenv("NEOVIM")),
})
