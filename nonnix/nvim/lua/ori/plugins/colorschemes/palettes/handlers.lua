local M = {
  valid_colorschemes = { "catppuccin", "monochrome" },
  effected_plugins = { "feline.nvim", "modes.nvim", "nvim-cokeline", "nvim-silicon" },
  default_switch_opts = {
    reload_effected_plugins = false,
  },
}

---@type fun(target_colorscheme: ValidColorschemes): boolean
function M.set_colorscheme(target_colorscheme)
  if not vim.tbl_contains(M.valid_colorschemes, target_colorscheme) then
    vim.notify(("Colorscheme '%s' not available"):format(target_colorscheme), vim.log.levels.WARN, {})
    return false
  end

  if vim.env.COLORSCHEME == target_colorscheme then
    vim.notify(("Colorscheme '%s' is already in use"):format(target_colorscheme), vim.log.levels.INFO, {})
    return false
  end

  vim.env.COLORSCHEME = target_colorscheme

  return true
end

---@type function
function M.reload_effected_plugins()
  require("ori.lib.utils.lazy").reload(M.effected_plugins)
end

---@type fun(target_colorscheme: ValidColorschemes, opts?: ColorschemeSwitchOpts)
function M.switch(target_colorscheme, opts)
  opts = vim.tbl_deep_extend("keep", opts or {}, M.default_switch_opts)

  local should_continue = M.set_colorscheme(target_colorscheme)
  if not should_continue then
    return
  end

  if opts.reload_effected_plugins then
    M.reload_effected_plugins()
  end

  vim.cmd.colorscheme(target_colorscheme)
end

---@type fun(): Palette
function M.palette()
  local colorscheme = vim.env.COLORSCHEME

  local ok, palette = pcall(require, ("ori.plugins.colorschemes.palettes.%s"):format(colorscheme))
  if not ok then
    error(("Unable to load palette: %s"):format(colorscheme))
  end

  return palette
end

return M
