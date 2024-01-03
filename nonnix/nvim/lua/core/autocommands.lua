local augroup, autocmd = vim.api.nvim_create_augroup, vim.api.nvim_create_autocmd

augroup("general_settings", {})
autocmd("TextYankPost", {
  group = "general_settings",
  pattern = "*",
  callback = function()
    require("vim.highlight").on_yank({ higroup = "Search", timeout = 200 })
  end,
})
autocmd("FileType", {
  group = "general_settings",
  pattern = "qf",
  callback = function()
    vim.opt.nobuflisted = true
  end,
})

augroup("auto_resize", {})
autocmd("VimResized", {
  group = "auto_resize",
  pattern = "*",
  command = "tabdo wincmd =",
})
