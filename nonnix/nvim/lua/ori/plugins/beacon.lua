return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { beacon = true },
    },
  },
  {
    "danilamihailov/beacon.nvim",
    event = "CursorMoved",
    config = function()
      for key, value in pairs({
        beacon_enable = 1,
        beacon_show_jumps = 1,
        beacon_shrink = 1,
        beacon_fade = 1,
        beacon_ignore_buffers = {},
        beacon_ignore_filetypes = {},
      }) do
        vim.g[key] = value
      end
    end,
  },
}
