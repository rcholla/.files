return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = function(_, opts)
      opts.integrations = vim.tbl_deep_extend("force", opts.integrations, {
        lsp_saga = true,
      })

      opts.custom_highlights = vim.tbl_deep_extend("force", opts.custom_highlights, {
        SagaBorder = { bg = opts.C.color23 }, -- lspsaga.nvim
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    keys = {
      { "<C-t>", "<CMD>Lspsaga term_toggle<CR>" },
      { "<C-o>", "<CMD>Lspsaga outline<CR>" },
      { "<C-g>", "<CMD>Lspsaga finder<CR>" },
      { "gd", "<CMD>Lspsaga goto_definition<CR>" },
      { "gD", "<CMD>Lspsaga peek_definition<CR>" },
      { "gl", "<CMD>Lspsaga show_line_diagnostics<CR>" },
    },
    opts = function()
      return {
        symbol_in_winbar = { enable = false },
        code_action = {
          num_shortcut = true,
          show_server_name = true,
          keys = {
            quit = "<ESC>",
            exec = "<CR>",
          },
        },
        finder = { keys = { quit = "<ESC>" } },
        lightbulb = {
          enable = true,
          enable_in_insert = true,
          virtual_text = false,
        },
        outline = {
          win_width = 37,
          keys = {
            jump = "<CR>",
            quit = "<ESC>",
          },
        },
        ui = {
          border = "rounded",
          devicon = true,
          title = true,
          kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        },
        beacon = {
          enable = true,
          frequency = 10,
        },
        scroll_preview = {
          scroll_up = "<C-A-k>",
          scroll_down = "<C-A-j>",
        },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>a", ":Lspsaga code_action<CR>", desc = "Code Action" },
      })
    end,
  },
}
