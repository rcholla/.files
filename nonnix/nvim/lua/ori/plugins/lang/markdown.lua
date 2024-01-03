return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { markdown = true },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    event = ("BufReadPre %s/**.md"):format(os.getenv("USERENV_OBSIDIAN_DIR")),
    dependencies = {
      { "oflisback/obsidian-bridge.nvim", config = true },
    },
    opts = function()
      vim.opt.conceallevel = 1

      return {
        dir = os.getenv("USERENV_OBSIDIAN_DIR"),
        log_level = vim.log.levels.WARN,
        completion = { min_chars = 1 },
        mappings = {},
        templates = { subdir = "_templates" },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      binds = {
        n = {
          o = {
            name = "Obsidian",
            o = { ":ObsidianOpen<CR>", "Open" },
            n = { ":ObsidianNew<CR>", "New note" },
            q = { ":ObsidianQuickSwitch<CR>", "Quick switch" },
            f = { ":ObsidianFollowLink<CR>", "Follow link" },
            b = { ":ObsidianBacklinks<CR>", "Backlinks" },
            t = { ":ObsidianToday<CR>", "Today" },
            y = { ":ObsidianYesterday<CR>", "Yesterday" },
            T = { ":ObsidianTemplate<CR>", "Template" },
            s = { ":ObsidianSearch<CR>", "Search" },
          },
        },
        v = {
          o = {
            name = "Obsidian",
            l = { ":ObsidianLink<CR>", "Link" },
            L = { ":ObsidianLinkNew<CR>", "Link new" },
          },
        },
      },
    },
  },
}
