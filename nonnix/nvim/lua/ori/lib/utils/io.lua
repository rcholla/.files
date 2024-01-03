local M = {}

---@type fun(program: string, ...: readmode): unknown
function M.read(program, ...)
  local handle = io.popen(program)
  if handle ~= nil then
    local out = handle:read(...)
    handle:close()
    return out
  end
  return nil
end

---@type fun(filename: string): boolean
function M.file_exists(filename)
  local file = io.open(filename, "r")
  local exists = file ~= nil
  if exists then
    io.close(file)
  end
  return exists
end

return M
