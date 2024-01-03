local M = {}

---@type fun(min_width: integer): boolean
function M.width_greater_than(min_width)
  return vim.api.nvim_win_get_width(0) > min_width
end

return M
