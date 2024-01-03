return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              format = {
                enable = false,
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [("%s/nonnix/nvim/lua"):format(os.getenv("DOTFILES"))] = true,
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "rcholla/guard.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ft = vim.list_extend(opts.ft, {
        { "lua", fmt = "stylua", lint = "luacheck" },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      opts.cmp_sources = vim.list_extend(opts.cmp_sources, {
        { name = "nvim_lua" },
      })

      opts.lspkind_opts = vim.tbl_deep_extend("force", opts.lspkind_opts, {
        menu = { nvim_lua = ">- NLua" },
      })
    end,
  },
}
