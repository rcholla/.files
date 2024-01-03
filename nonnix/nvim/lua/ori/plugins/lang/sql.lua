return {
  {
    "tpope/vim-dadbod",
    ft = { "sql", "mysql", "plsql" },
    keys = { { "<C-y>", "<CMD>DBUI<CR>" } },
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-ui",
        config = function()
          vim.g.db_ui_use_nerd_fonts = 1
          vim.g.db_ui_winwidth = 50

          vim.api.nvim_create_autocmd("FileType", {
            pattern = "dbui",
            callback = function()
              local keymap, opts = vim.keymap.set, { buffer = true }

              keymap("n", "a", "<Plug>(DBUI_AddConnection)", opts)
              keymap("n", "e", "<Plug>(DBUI_EditBindParameters)", opts)
              keymap("n", "h", "<Plug>(DBUI_SelectLineVsplit)", opts)
              keymap("n", "l", "<Plug>(DBUI_SelectLineVsplit)", opts)
              keymap("n", "w", "<Plug>(DBUI_SaveQuery)", opts)
            end,
          })
        end,
      },
      {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = {
          {
            "hrsh7th/nvim-cmp",
            optional = true,
            opts = function(_, opts)
              opts.cmp_sources = vim.list_extend(opts.cmp_sources, {
                { name = "vim-dadbod-completion" },
              })

              opts.lspkind_opts = vim.tbl_deep_extend("force", opts.lspkind_opts, {
                menu = { ["vim-dadbod-completion"] = ">- DB" },
              })
            end,
          },
        },
        config = function()
          vim.g.vim_dadbod_completion_mark = ""
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        sqls = {},
      },
    },
  },
  {
    "rcholla/guard.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ft = vim.list_extend(opts.ft, {
        { "sql", fmt = "sqlfluff", lint = "sqlfluff" },
      })
    end,
  },
}
