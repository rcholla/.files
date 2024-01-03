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
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>T", ":Trouble diagnostics<CR>", desc = "Trouble" },
      })
    end,
  },
}
