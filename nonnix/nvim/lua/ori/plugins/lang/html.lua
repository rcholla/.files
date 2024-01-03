return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        html = {
          init_options = {
            provideFormatter = false,
          },
        },
        emmet_language_server = {},
      },
    },
  },
}
