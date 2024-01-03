return {
  "chrishrb/gx.nvim",
  cmd = "Browse",
  keys = { { "gx", "<CMD>Browse<CR>", mode = { "n", "x" } } },
  opts = function()
    vim.g.netrw_nogx = 1

    return {
      open_browser_app = "xdg-open",
      handlers = {
        plugin = true,
        github = true,
        package_json = true,
        search = true,
      },
      handler_options = { search_engine = "duckduckgo" },
    }
  end,
}
