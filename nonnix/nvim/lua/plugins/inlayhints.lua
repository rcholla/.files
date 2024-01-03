return {
  "lvimuser/lsp-inlayhints.nvim",
  lazy = true,
  keys = {
    {
      "<C-i>",
      function()
        require("lsp-inlayhints").toggle()
      end,
    },
  },
  opts = {
    inlay_hints = {
      parameter_hints = {
        show = true,
        prefix = "=> ",
        separator = ", ",
        remove_colon_start = true,
        remove_colon_end = true,
      },
      type_hints = {
        show = true,
        prefix = ">- ",
        separator = ", ",
        remove_colon_start = true,
        remove_colon_end = true,
      },
      only_current_line = false,
      labels_separator = " ",
      highlight = "LspInlayHint",
      priority = 0,
    },
  },
}
