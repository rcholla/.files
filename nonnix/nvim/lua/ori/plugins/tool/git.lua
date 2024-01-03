return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { gitsigns = true },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>g", group = "Git" },
        { "<leader>gb", ":lua require('gitsigns').blame_line()<CR>", desc = "Blame line" },
        { "<leader>gj", ":lua require('gitsigns').next_hunk()<CR>", desc = "Next hunk" },
        { "<leader>gk", ":lua require('gitsigns').prev_hunk()<CR>", desc = "Prev hunk" },
        { "<leader>gp", ":lua require('gitsigns').preview_hunk()<CR>", desc = "Preview hunk" },
        { "<leader>gr", ":lua require('gitsigns').reset_hunk()<CR>", desc = "Reset hunk" },
        { "<leader>gR", ":lua require('gitsigns').reset_buffer()<CR>", desc = "Reset buffer" },
        { "<leader>gs", ":lua require('gitsigns').stage_hunk()<CR>", desc = "Stage hunk" },
        { "<leader>gu", ":lua require('gitsigns').undo_stage_hunk()<CR>", desc = "Undo stage hunk" },
      })
    end,
  },
}
