return {
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
          [("%s/lua"):format(vim.fn.stdpath("config"))] = true,
          [("%s/nonnix/nvim/lua"):format(os.getenv("DOTFILES"))] = true,
        },
      },
    },
  },
}
