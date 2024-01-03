local M = {}

---@type fun(path: string)
function M.install(path)
  if not (vim.uv or vim.loop).fs_stat(path) then
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        {
          vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--branch=stable",
            "https://github.com/folke/lazy.nvim.git",
            path,
          }),
          "WarningMsg",
        },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(path)
end

---@type fun(path: string, fn: table<string, unknown>|fun(lazy: unknown))
function M.install_and_then(path, fn)
  M.install(path)

  local lazy = require("lazy")

  local typeof = type(fn)
  if typeof == "table" then
    lazy.setup(fn)
  elseif typeof == "function" then
    fn(lazy)
  end
end

return M
