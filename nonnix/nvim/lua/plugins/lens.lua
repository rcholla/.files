return {
  "VidocqH/lsp-lens.nvim",
  event = "VeryLazy",
  keys = { { "<C-;>", "<CMD>LspLensToggle<CR>" } },
  opts = {
    enable = true,
    include_declaration = true,
    sections = {
      definition = true,
      references = true,
      implements = true,
    },
  },
}
