local M = {}

---@type fun(program: string, ...: readmode): any
function M.read(program, ...)
  local handle = io.popen(program)
  if handle ~= nil then
    local out = handle:read(...)
    handle:close()
    return out
  end
end

return M
