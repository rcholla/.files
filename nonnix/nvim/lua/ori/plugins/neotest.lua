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
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>t", group = "Test" },
        { "<leader>tr", ":lua require('neotest').run.run()<CR>", desc = "Run nearest test" },
        { "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run current file" },
        { "<leader>td", ":lua require('neotest').run.run({ strategy = 'dap' })<CR>", desc = "Debug nearest test" },
        { "<leader>ts", ":lua require('neotest').run.stop()<CR>", desc = "Stop nearest test" },
        { "<leader>ta", ":lua require('neotest').run.attach()<CR>", desc = "Attach to nearest test" },
        { "<leader>to", ":lua require('neotest').output.open({ enter = true })<CR>", desc = "Output" },
        { "<leader>tS", ":lua require('neotest').summary.toggle()<CR>", desc = "Summary" },
      })
    end,
  },
}
