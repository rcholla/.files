return {
  "folke/noice.nvim",
  event = "VeryLazy",
  keys = {
    {
      "K",
      function()
        require("noice.lsp").hover()
      end,
    },
  },
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
    },
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = "virtualtext",
    },
    popupmenu = {
      enabled = true,
      backend = "nui",
    },
    notify = {
      enabled = true,
      view = "notify",
    },
    lsp = {
      progress = { enabled = true },
      hover = { enabled = true, silent = true },
      signature = { enabled = true },
      message = { enabled = true },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    smart_move = {
      enabled = true,
      excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
    },
    presets = {
      command_palette = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    routes = {
      {
        filter = { event = "msg_show", find = "%d+L, %d+B" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "<" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "line" },
        opts = { skip = true },
      },
    },
  },
}
