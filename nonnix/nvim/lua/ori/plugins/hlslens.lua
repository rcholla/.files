return {
  "kevinhwang91/nvim-hlslens",
  keys = {
    { "n", "<CMD>execute('normal! ' . v:count1 . 'n')<CR><CMD>lua require('hlslens').start()<CR>" },
    { "N", "<CMD>execute('normal! ' . v:count1 . 'N')<CR><CMD>lua require('hlslens').start()<CR>" },
    { "<C-n>", "*<CMD>lua require('hlslens').start()<CR>" },
    { "<C-p>", "#<CMD>lua require('hlslens').start()<CR>" },
    { "<C-\\>", "<CMD>noh<CR>" },
  },
  config = true,
}
