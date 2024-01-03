return {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  keys = {
    {
      "<C-r>",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      mode = { "n", "i" },
      expr = true,
    },
  },
  config = true,
}
