return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = function(_, opts)
      opts.integrations = vim.tbl_deep_extend("force", opts.integrations, {
        neotree = true,
      })

      opts.custom_highlights = vim.tbl_deep_extend("force", opts.custom_highlights, {
        NeoTreeNormalNC = { bg = opts.C.color24 }, -- neo-tree.nvim
        NeoTreeTabInactive = { fg = opts.C.color19, bg = opts.C.color24 },
        NeoTreeTabSeparatorInactive = { fg = opts.C.color24, bg = opts.C.color24 },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = {
          { source = "filesystem" },
          { source = "buffers" },
          { source = "git_status" },
        },
      },
      default_component_configs = { indent = { padding = 0 } },
      window = {
        position = "left",
        width = 37,
        mapping_options = { noremap = true, nowait = true },
        mappings = {
          ["<2-LeftMouse>"] = "open",
          ["<CR>"] = "open",
          ["l"] = "open",
          ["<esc>"] = "revert_preview",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["h"] = "close_node",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["a"] = { "add", config = { show_path = "relative" } },
          ["A"] = { "add_directory", config = { show_path = "relative" } },
          ["d"] = function(state)
            local inputs = require("neo-tree.ui.inputs")
            local path = state.tree:get_node().path
            local message = ("Are you sure you want to delete '%s'"):format(state.tree:get_node().name)
            inputs.confirm(message, function(confirmed)
              if confirmed then
                vim.fn.system({ "trash", vim.fn.fnameescape(path) })
                require("neo-tree.sources.manager").refresh(state.name)
              end
            end)
          end,
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy",
          ["m"] = "move",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<A-h>"] = "prev_source",
          ["<A-l>"] = "next_source",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
        follow_current_file = { enabled = true },
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ["u"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["\\"] = "fuzzy_finder_directory",
            ["f"] = "filter_on_submit",
            ["F"] = "clear_filter",
          },
        },
      },
      buffers = {
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
          mappings = {
            ["d"] = "buffer_delete",
            ["u"] = "navigate_up",
            ["."] = "set_root",
          },
        },
      },
      event_handlers = {
        {
          event = "neo_tree_popup_input_ready",
          handler = function(_)
            vim.cmd("stopinsert")
          end,
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>e", ":Neotree toggle<CR>", desc = "Neotree" },
      })
    end,
  },
}
