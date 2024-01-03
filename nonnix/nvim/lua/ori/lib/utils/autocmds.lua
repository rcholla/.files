local M = {}

---@type fun(event: any, opts: vim.api.keyset.create_autocmd): integer
M.autocmd = vim.api.nvim_create_autocmd

---@type fun(name: string, fn: fun(group: integer))
function M.augroup(name, fn)
  fn(vim.api.nvim_create_augroup(name, { clear = true }))
end

return M
