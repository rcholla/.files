return {
  {
    "Vigemus/iron.nvim",
    main = "iron.core",
    opts = {
      config = {
        repl_open_cmd = "horizontal bot 20 split",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>R", ":IronFocus<CR>", desc = "Repl" },
      })
    end,
  },
}
