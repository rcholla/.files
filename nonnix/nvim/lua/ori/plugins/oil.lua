return {
  "stevearc/oil.nvim",
  event = "VimEnter",
  keys = function()
    local function toggle_oil()
      if vim.bo.filetype ~= "oil" then
        require("oil").open()
      else
        require("oil").close()
      end
    end

    return { { "<C-e>", toggle_oil } }
  end,
  opts = function()
    vim.api.nvim_set_hl(
      0,
      "OilNormal",
      { bg = require("ori.plugins.colorschemes.palettes.handlers").palette().color24 }
    )

    return {
      default_file_explorer = true,
      delete_to_trash = true,
      experimental_watch_for_changes = true,
      view_options = { show_hidden = true },
      columns = { "type", "size", "icon" },
      win_options = { winhl = "Normal:OilNormal" },
      float = { padding = 15 },
      keymaps = {
        ["q"] = "actions.close",
        ["h"] = "actions.parent",
        ["l"] = "actions.select",
      },
    }
  end,
}
