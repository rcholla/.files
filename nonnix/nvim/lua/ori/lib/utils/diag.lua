local M = {}

---@type fun(severity: vim.diagnostic.Severity): string
function M.get_diagnostic(severity)
  return tostring(vim.tbl_count(vim.diagnostic.get(0, severity and { severity = severity })))
end

return M
