return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { hop = true },
    },
  },
  {
    "phaazon/hop.nvim",
    keys = {
      { "f", "<CMD>lua require'hop'.hint_words()<CR>", mode = "" },
      { "F", "<CMD>lua require'hop'.hint_words({ current_line_only = true })<CR>", mode = "" },
    },
    config = true,
  },
}
