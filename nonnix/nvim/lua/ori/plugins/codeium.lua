return {
  "Exafunction/codeium.vim",
  event = "InsertEnter",
  keys = {
    { "<C-/>", "<CMD>CodeiumToggle<CR>" },
    {
      "<C-l>",
      function()
        return vim.fn["codeium#Accept"]()
      end,
      mode = "i",
      expr = true,
      silent = true,
    },
    {
      "<C-c>",
      function()
        return vim.fn["codeium#Complete"]()
      end,
      mode = "i",
    },
    {
      "<C-A-c>",
      function()
        return vim.fn["codeium#Clear"]()
      end,
      mode = "i",
    },
    {
      "<C-j>",
      function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end,
      mode = "i",
    },
    {
      "<C-k>",
      function()
        return vim.fn["codeium#CycleCompletions"](1)
      end,
      mode = "i",
    },
  },
  config = function()
    vim.g.codeium_disable_bindings = 1
  end,
}
