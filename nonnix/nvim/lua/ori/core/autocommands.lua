local utils = require("ori.lib.utils.autocmds")
local augroup, autocmd = utils.augroup, utils.autocmd

augroup("highlight_yank", function(group)
  autocmd("TextYankPost", {
    group = group,
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
    end,
  })
end)

augroup("resize_splits", function(group)
  autocmd("VimResized", {
    group = group,
    callback = function()
      vim.cmd(([[
      tabdo wincmd =
      tabnext %s
    ]]):format(vim.fn.tabpagenr()))
    end,
  })
end)
