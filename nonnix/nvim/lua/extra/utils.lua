local M = {}

---@param program string
---@param ... readmode
---@return any
function M.ioread(program, ...)
  local handle = io.popen(program)
  if handle ~= nil then
    local output = handle:read(...)
    handle:close()
    return output
  end
end

---@return boolean
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

---@param thing any
---@return boolean
function M.is_nil_or_empty(thing)
  return thing == nil or thing == ""
end

---@param min_width integer
---@return boolean
function M.win_width_greater_than(min_width)
  return vim.api.nvim_win_get_width(0) > min_width
end

---@param type string
---@return string
function M.git_diff(type)
  local gsd = vim.b.gitsigns_status_dict
  if gsd and gsd[type] then
    return tostring(gsd[type])
  end
  return ""
end

---@param severity vim.diagnostic.Severity
---@return string
function M.get_diagnostic(severity)
  return tostring(vim.tbl_count(vim.diagnostic.get(0, severity and { severity = severity })))
end

return M
