local M = {}

---@type fun(plugin: string): boolean
function M.is_loaded(plugin) -- stolen from https://github.com/LazyVim/LazyVim/blob/ae6d8f1a34fff49f9f1abf9fdd8a559c95b85cf3/lua/lazyvim/util/init.lua#L131
  local Config = require("lazy.core.config")
  return Config.plugins[plugin] and Config.plugins[plugin]._.loaded
end

---@type fun(plugin: string, fn: fun(plugin: string))
function M.on_load(plugin, fn) -- stolen from https://github.com/LazyVim/LazyVim/blob/ae6d8f1a34fff49f9f1abf9fdd8a559c95b85cf3/lua/lazyvim/util/init.lua#L138
  if M.is_loaded(plugin) then
    fn(plugin)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == plugin then
          fn(plugin)
          return true
        end
      end,
    })
  end
end

---@type fun(plugins: string[])
function M.reload(plugins)
  require("lazy").reload({ plugins = vim.tbl_filter(M.is_loaded, plugins) })
end

return M
