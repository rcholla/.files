return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { notify = true },
    },
  },
  { "nvim-neotest/nvim-nio", lazy = true },
  { "kyazdani42/nvim-web-devicons", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true },
  { "stevearc/dressing.nvim", lazy = true },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = function()
      local icons = require("ori.lib.icons")

      return {
        stages = "slide",
        icons = {
          ERROR = icons.notify.Error,
          WARN = icons.notify.Warn,
          INFO = icons.notify.Info,
          DEBUG = icons.notify.Debug,
          TRACE = icons.notify.Trace,
        },
      }
    end,
  },
}
