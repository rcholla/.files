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
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>o", group = "Obsidian" },
        { "<leader>oo", ":ObsidianOpen<CR>", desc = "Open" },
        { "<leader>on", ":ObsidianNew<CR>", desc = "New note" },
        { "<leader>oq", ":ObsidianQuickSwitch<CR>", desc = "Quick switch" },
        { "<leader>of", ":ObsidianFollowLink<CR>", desc = "Follow link" },
        { "<leader>ob", ":ObsidianBacklinks<CR>", desc = "Backlinks" },
        { "<leader>ot", ":ObsidianToday<CR>", desc = "Today" },
        { "<leader>oy", ":ObsidianYesterday<CR>", desc = "Yesterday" },
        { "<leader>oT", ":ObsidianTemplate<CR>", desc = "Template" },
        { "<leader>os", ":ObsidianSearch<CR>", desc = "Search" },
        { "<leader>o", group = "Obsidian", mode = "v" },
        { "<leader>ol", ":ObsidianLink<CR>", mode = "v", desc = "Link" },
        { "<leader>oL", ":ObsidianLinkNew<CR>", mode = "v", desc = "Link new" },
      })
    end,
  },
}
