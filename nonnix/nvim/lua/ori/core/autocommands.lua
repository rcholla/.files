local autocmd = vim.api.nvim_create_autocmd

---@type fun(name: string, fn: fun(group: integer))
local function augroup(name, fn)
  fn(vim.api.nvim_create_augroup(name, { clear = true }))
end

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
