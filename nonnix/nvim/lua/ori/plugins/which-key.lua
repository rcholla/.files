return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = function(_, opts)
      opts.integrations = vim.tbl_deep_extend("force", opts.integrations, {
        which_key = true,
      })

      opts.custom_highlights = vim.tbl_deep_extend("force", opts.custom_highlights, {
        WhichKeyFloat = { bg = opts.C.color23 }, -- which-key.nvim
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts_extend = { "spec" },
    opts = {
      preset = "modern",
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = true,
          g = true,
        },
      },
      win = {
        title = false,
        padding = { 2, 2 },
      },
      icons = { mappings = false },
      show_keys = false,
      disable = { ft = { "TelescopePrompt", "neo-tree", "oil" } },
    },
  },
}
