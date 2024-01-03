return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { lsp_trouble = true },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      binds = {
        n = {
          t = { ":Trouble diagnostics<CR>", "Trouble" },
        },
      },
    },
  },
}
