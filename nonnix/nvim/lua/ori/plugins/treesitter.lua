return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = function(_, opts)
      opts.integrations = vim.tbl_deep_extend("force", opts.integrations, {
        treesitter = true,
        treesitter_context = true,
        rainbow_delimiters = true,
      })

      opts.custom_highlights = vim.tbl_deep_extend("force", opts.custom_highlights, {
        TreesitterContext = { bg = opts.C.color24 }, -- nvim-treesitter-context
        RainbowDelimiterRed = { fg = opts.C.color04 }, --- rainbow-delimiters.nvim
        RainbowDelimiterYellow = { fg = opts.C.color07 },
        RainbowDelimiterBlue = { fg = opts.C.color12 },
        RainbowDelimiterOrange = { fg = opts.C.color06 },
        RainbowDelimiterGreen = { fg = opts.C.color08 },
        RainbowDelimiterViolet = { fg = opts.C.color03 },
        RainbowDelimiterCyan = { fg = opts.C.color11 },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    dependencies = {},
    opts = {
      ensure_installed = "all",
      highlight = {
        enable = true,
        disable = function(_, buf)
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          local max_filesize = 100 * 1024
          return ok and stats and stats.size > max_filesize
        end,
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = { enable = true, disable = { "yaml" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          node_decremental = "<C-A-Space>",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      tabout = { enable = true },
    },
  },
  {
    "axelvc/template-string.nvim",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      remove_template_string = true,
      restore_quotes = { normal = [["]] },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "markdown" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          tsx = "rainbow-parens",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
}
