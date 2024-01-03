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
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      binds = {
        n = {
          g = {
            name = "Git",
            l = { ":lua require('gitsigns').blame_line()<CR>", "Blame line" },
            j = { ":lua require('gitsigns').next_hunk()<CR>", "Next hunk" },
            k = { ":lua require('gitsigns').prev_hunk()<CR>", "Prev hunk" },
            p = { ":lua require('gitsigns').preview_hunk()<CR>", "Preview hunk" },
            r = { ":lua require('gitsigns').reset_hunk()<CR>", "Reset hunk" },
            R = { ":lua require('gitsigns').reset_buffer()<CR>", "Reset buffer" },
            s = { ":lua require('gitsigns').stage_hunk()<CR>", "Stage hunk" },
            u = { ":lua require('gitsigns').undo_stage_hunk()<CR>", "Undo stage hunk" },
          },
        },
      },
    },
  },
}
