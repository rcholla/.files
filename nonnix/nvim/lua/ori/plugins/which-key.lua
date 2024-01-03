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
    cmd = "WhichKey",
    keys = "<leader>",
    opts = {
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
      window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
      },
      layout = {
        align = "center",
      },
      ignore_missing = true,
      show_keys = false,
      disable = { filetypes = { "TelescopePrompt", "neo-tree" } },
      excluded_opts = { "excluded_opts", "binds" }, -- custom option
      binds = { -- custom option
        n = {},
        v = {},
      },
    },
    config = function(_, opts)
      local whichkey = require("which-key")

      whichkey.setup(require("ori.lib.utils.tbl").exclude(opts, opts.excluded_opts))

      whichkey.register(opts.binds.n, {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      })
      whichkey.register(opts.binds.v, {
        mode = "v",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      })
    end,
  },
}
