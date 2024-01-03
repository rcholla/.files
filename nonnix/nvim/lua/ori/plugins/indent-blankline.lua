return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { indent_blankline = { enabled = true, scope_color = "lavender", colored_indent_levels = false } },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
      indent = { char = "▏" },
      scope = { show_start = false, show_end = false },
    },
  },
}
