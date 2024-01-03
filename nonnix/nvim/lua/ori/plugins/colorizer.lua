return {
  "NvChad/nvim-colorizer.lua",
  event = "VeryLazy",
  opts = {
    filetypes = { "*" },
    user_default_options = {
      mode = "background",
      tailwind = false,
      names = false,
      RRGGBBAA = true,
      AARRGGBB = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      sass = {
        enable = true,
        parsers = { "css" },
      },
    },
  },
}
