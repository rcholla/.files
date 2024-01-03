require("ori.core")

local lazypath = ("%s/lazy/lazy.nvim"):format(vim.fn.stdpath("data"))
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "ori.plugins.colorschemes" },
    { import = "ori.plugins" },
    { import = "ori.plugins.lang" },
    { import = "ori.plugins.tool" },
  },
  ui = {
    border = "rounded",
  },
})
