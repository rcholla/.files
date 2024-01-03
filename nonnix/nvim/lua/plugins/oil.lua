return {
  "stevearc/oil.nvim",
  event = "VimEnter",
  keys = {
    {
      "<C-e>",
      function()
        require("oil").toggle_float()
      end,
    },
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    experimental_watch_for_changes = true,
    view_options = { show_hidden = true },
    columns = { "type", "size", "icon" },
    float = { padding = 15 },
    keymaps = {
      ["q"] = "actions.close",
      ["h"] = "actions.parent",
      ["l"] = "actions.select",
    },
  },
}
