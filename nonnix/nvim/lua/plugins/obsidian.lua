return {
  "epwalsh/obsidian.nvim",
  event = ("BufReadPre %s/**.md"):format(os.getenv("NVIM_OBSIDIAN_DIR")),
  dependencies = { { "oflisback/obsidian-bridge.nvim", config = true } },
  opts = function()
    vim.opt.conceallevel = 1

    return {
      dir = os.getenv("NVIM_OBSIDIAN_DIR"),
      log_level = vim.log.levels.WARN,
      completion = { min_chars = 1 },
      mappings = {},
      templates = { subdir = "_templates" },
    }
  end,
}
