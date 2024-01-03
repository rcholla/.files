return {
  "mvllow/modes.nvim",
  event = "VeryLazy",
  opts = function()
    local C = require("ori.plugins.colorschemes.palettes.handlers").palette()

    return {
      colors = {
        copy = C.color02,
        delete = C.color04,
        insert = C.color10,
        visual = C.color03,
      },
      line_opacity = 0.2,
    }
  end,
}
