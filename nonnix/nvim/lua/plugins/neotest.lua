return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
    "mrcjkb/neotest-haskell",
    "nvim-neotest/neotest-vim-test",
    "vim-test/vim-test",
  },
  opts = function()
    return {
      adapters = {
        require("neotest-vitest"),
        require("neotest-go"),
        require("neotest-rust"),
        require("neotest-haskell"),
        require("neotest-vim-test")({
          ignore_file_types = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "go",
            "rust",
            "haskell",
          },
        }),
      },
    }
  end,
}
