return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        bashls = {
          settings = {
            bashIde = {
              shellcheckPath = "",
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
        { "bash,sh,zsh", fmt = "shfmt", lint = "shellcheck" },
      })
    end,
  },
}
