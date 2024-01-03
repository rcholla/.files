return {
  "mrjones2014/smart-splits.nvim",
  keys = {
    {
      "<C-A-r>",
      function()
        require("smart-splits").start_resize_mode()
      end,
    },
  },
  opts = {
    ignored_filetypes = { "sagaoutline", "neo-tree" },
    default_amount = 1,
    resize_mode = {
      silent = true,
    },
  },
}
