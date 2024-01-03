return {
  "numToStr/Comment.nvim",
  keys = {
    { "<C-w>", "<ESC><Plug>(comment_toggle_linewise_current)", mode = { "n", "i" } },
    { "<C-w>", "<Plug>(comment_toggle_blockwise_visual)", mode = "x" },
  },
  opts = function()
    return {
      mappings = { basic = false, extra = false },
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
}
