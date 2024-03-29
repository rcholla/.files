C = {
  colorscheme = "catppuccin",
  flavor = "mocha",
}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = function()
    C = vim.tbl_extend("keep", C, require("catppuccin.palettes").get_palette(C.flavor))

    return {
      flavour = C.flavor,
      term_colors = true,
      no_italic = true,
      no_bold = false,
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
      highlight_overrides = {},
      custom_highlights = {
        NormalFloat = { bg = C.base },
        TabLineFill = { bg = C.mantle },
        CursorLineNr = { fg = C.red },
        OutlineNormal = { bg = C.mantle },
        LspInlayHint = { fg = C.overlay0, bg = "" },
        SagaBorder = { bg = C.base },
        WhichKeyFloat = { bg = C.base },
        TreesitterContext = { bg = C.mantle },
        NoiceCursor = { fg = C.crust, bg = C.text },
        NeoTreeNormalNC = { bg = C.mantle },
        NeoTreeTabInactive = { fg = C.overlay0, bg = C.mantle },
        NeoTreeTabSeparatorInactive = { fg = C.mantle, bg = C.mantle },
        RainbowDelimiterRed = { fg = C.red },
        RainbowDelimiterYellow = { fg = C.yellow },
        RainbowDelimiterBlue = { fg = C.blue },
        RainbowDelimiterOrange = { fg = C.peach },
        RainbowDelimiterGreen = { fg = C.green },
        RainbowDelimiterViolet = { fg = C.mauve },
        RainbowDelimiterCyan = { fg = C.sapphire },
        PackageInfoUpToDateVersion = { default = true, link = "DiagnosticVirtualTextInfo" },
        PackageInfoOutdatedVersion = { default = true, link = "DiagnosticVirtualTextWarn" },
      },
      integrations = {
        alpha = true,
        beacon = true,
        cmp = true,
        dap = {
          enabled = true,
          enable_ui = true,
        },
        gitsigns = true,
        hop = true,
        indent_blankline = {
          enabled = true,
          scope_color = "lavender",
          colored_indent_levels = false,
        },
        lsp_saga = true,
        markdown = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = { background = true },
        },
        navic = {
          enabled = true,
          custom_bg = C.mantle,
        },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        rainbow_delimiters = true,
        semantic_tokens = true,
        telescope = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    }
  end,
  init = function()
    vim.cmd.colorscheme(C.colorscheme)
  end,
}
