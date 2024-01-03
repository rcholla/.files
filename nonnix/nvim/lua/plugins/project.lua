return {
  "ahmedkhalf/project.nvim",
  main = "project_nvim",
  event = "VeryLazy",
  opts = {
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "Makefile", "package.json", "package.yaml", "Cargo.toml", "stack.yaml" },
    show_hidden = true,
    silent_chdir = true,
  },
}
