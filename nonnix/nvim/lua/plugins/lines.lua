return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  event = "VeryLazy",
  keys = function()
    local active = true
    local function toggle_lsplines()
      vim.diagnostic.config(active and { virtual_lines = false } or { virtual_lines = { only_current_line = true } })
      active = not active
    end

    return { { "<C-'>", toggle_lsplines } }
  end,
  config = true,
}
