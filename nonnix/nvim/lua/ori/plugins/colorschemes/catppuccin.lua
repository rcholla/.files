local C = {
  colorscheme = "catppuccin",
  flavor = "mocha",
}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = function()
    return {
      flavour = C.flavor,
      term_colors = true,
      no_bold = false,
      no_italic = true,
      no_underline = false,
      styles = {
        comments = {},
        conditionals = { "bold" },
        loops = { "bold" },
        functions = { "bold" },
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = { "bold" },
        operators = {},
      },
      color_overrides = {},
      highlight_overrides = {
        mocha = function(M)
          return {
            NormalFloat = { bg = M.base },
            CursorLineNr = { fg = M.red },
            TabLineFill = { bg = M.mantle },
            OutlineNormal = { bg = M.mantle },
            LspInlayHint = { fg = M.overlay0, bg = "" },
          }
        end,
      },
      custom_highlights = {},
      excluded_opts = { "excluded_opts", "C" }, -- custom option
      C = require("ori.plugins.colorschemes.palettes.catppuccin"), -- custom option
    }
  end,
  config = function(_, opts)
    require("catppuccin").setup(require("ori.lib.utils.tbl").exclude(opts, opts.excluded_opts))

    local handlers = require("ori.plugins.colorschemes.palettes.handlers")

    vim.api.nvim_create_user_command("Catppuccin", function()
      handlers.switch("catppuccin", { reload_effected_plugins = true })
    end, {})

    handlers.switch("catppuccin")
  end,
}
