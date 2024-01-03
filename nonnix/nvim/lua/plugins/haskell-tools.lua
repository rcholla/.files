return {
  "mrcjkb/haskell-tools.nvim",
  ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  init = function()
    vim.g.haskell_tools = {
      hls = {
        on_attach = function(client, bufnr, _)
          require("plugins.lsp.handlers").on_attach(client, bufnr)
        end,
        settings = {
          haskell = {
            plugin = {
              hlint = { globalOn = false },
            },
          },
        },
      },
      dap = { auto_discover = false },
      tools = { tags = { enable = false } },
    }
  end,
}
