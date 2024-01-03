return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      telescope = { enabled = true },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = function()
      local actions, icons = require("telescope.actions"), require("ori.lib.icons")

      return {
        defaults = {
          path_display = { "smart" },
          prompt_prefix = ("%s "):format(icons.misc.Prompt),
          selection_caret = ("%s "):format(icons.misc.Selection),
          file_ignore_patterns = {
            "LICENSE",
            "Cargo.lock",
            "flake.lock",
            "dist/",
            "node_modules/",
            "target/",
            ".git/",
            ".next/",
            ".obsidian/",
          },
          mappings = {
            i = {
              ["<C-h>"] = actions.cycle_history_next,
              ["<C-l>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-A-k>"] = actions.preview_scrolling_up,
              ["<C-A-j>"] = actions.preview_scrolling_down,
              ["<C-/>"] = actions.which_key,
            },
            n = {
              ["<ESC>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["K"] = actions.move_to_top,
              ["J"] = actions.move_to_bottom,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-A-k>"] = actions.preview_scrolling_up,
              ["<C-A-j>"] = actions.preview_scrolling_down,
              ["?"] = actions.which_key,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)

      telescope.load_extension("media_files")
      telescope.load_extension("ui-select")
      telescope.load_extension("projects")
      telescope.load_extension("fzf")
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        {
          "<leader>f",
          ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false, hidden = true }))<CR>",
          desc = "Files",
        },
        { "<leader>m", ":Telescope media_files<CR>", desc = "Media Files" },
        { "<leader>F", ":Telescope live_grep<CR>", desc = "Live Grep" },
        { "<leader>p", ":Telescope projects<CR>", desc = "Projects" },
      })
    end,
  },
}
