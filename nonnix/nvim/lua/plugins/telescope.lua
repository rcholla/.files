return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "mrcjkb/telescope-manix",
  },
  opts = function()
    local actions, icons = require("telescope.actions"), require("extra.icons")

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
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")

    telescope.setup(opts)

    telescope.load_extension("package_info")
    telescope.load_extension("media_files")
    telescope.load_extension("ui-select")
    telescope.load_extension("projects")
    telescope.load_extension("manix")
    telescope.load_extension("fzf")
    telescope.load_extension("ht")
  end,
}
