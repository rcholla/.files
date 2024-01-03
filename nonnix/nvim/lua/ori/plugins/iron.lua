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
    opts = {
      binds = {
        n = {
          R = { ":IronFocus<CR>", "Repl" },
        },
      },
    },
  },
}
