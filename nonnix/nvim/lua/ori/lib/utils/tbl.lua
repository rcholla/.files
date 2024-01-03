local M = {}

---@type fun(tbl: table<string, unknown>, omit_keys: string|string[]): table
function M.exclude(tbl, omit_keys)
  local out = {}
  for k, v in pairs(tbl) do
    if type(omit_keys) == "string" then
      if k ~= omit_keys then
        out[k] = v
      end
    elseif type(omit_keys) == "table" then
      if not vim.tbl_contains(omit_keys, k) then
        out[k] = v
      end
    end
  end
  return out
end

return M
