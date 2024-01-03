return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { neotest = true },
    },
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/neotest-vim-test",
      "vim-test/vim-test",
    },
    opts = function()
      return {
        adapters = {
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
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      binds = {
        n = {
          t = {
            name = "Test",
            r = { ":lua require('neotest').run.run()<CR>", "Run nearest test" },
            f = { ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run current file" },
            d = { ":lua require('neotest').run.run({ strategy = 'dap' })<CR>", "Debug nearest test" },
            s = { ":lua require('neotest').run.stop()<CR>", "Stop nearest test" },
            a = { ":lua require('neotest').run.attach()<CR>", "Attach to nearest test" },
            o = { ":lua require('neotest').output.open({ enter = true })<CR>", "Output" },
            S = { ":lua require('neotest').summary.toggle()<CR>", "Summary" },
          },
        },
      },
    },
  },
}
