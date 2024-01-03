local M = {}

---@type fun(): boolean
function M.is_inactive_buffer()
  for _, filetype in pairs({
    "sagaoutline",
    "neo-tree",
    "ccc-ui",
    "alpha",
    "help",
    "qf",
  }) do
    if filetype == vim.bo.filetype then
      return true
    end
  end
  return false
end

return M
