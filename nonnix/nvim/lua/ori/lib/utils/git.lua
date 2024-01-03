local M = {}

---@type fun(type: string): string
function M.get_diff(type)
  local gsd = vim.b.gitsigns_status_dict
  if gsd and gsd[type] then
    return tostring(gsd[type])
  end
  return ""
end

return M
