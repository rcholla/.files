return {
  "mvllow/modes.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      colors = {
        copy = C.pink,
        delete = C.red,
        insert = C.sky,
        visual = C.mauve,
      },
      line_opacity = 0.2,
    }
  end,
}
