local M = {}

---@type fun(thing: any): boolean
function M.is_nil_or_empty(thing)
  return thing == nil or thing == ""
end

return M
