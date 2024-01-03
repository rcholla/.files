return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { cmp = true },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
    },
    opts = function()
      local cmp, luasnip = require("cmp"), require("luasnip")

      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
        },
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-A-k>"] = cmp.mapping.scroll_docs(-1),
          ["<C-A-j>"] = cmp.mapping.scroll_docs(1),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-l>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-ESC>"] = cmp.mapping.abort(),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = { ghost_text = true },
        excluded_opts = { "excluded_opts", "cmp_extra_format", "cmp_sources", "lspkind_opts" }, -- custom option
        cmp_extra_format = nil, -- custom option
        cmp_sources = { -- custom option
          { name = "nvim_lsp", trigger_characters = { "-" } },
          { name = "luasnip", max_item_count = 10 },
          { name = "path" },
        },
        lspkind_opts = { -- custom option
          mode = "symbol",
          menu = {
            nvim_lsp = ">- LSP",
            luasnip = ">- Snippet",
            path = ">- Path",
          },
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({ paths = ("%s/lua/plugins/snippets"):format(vim.fn.stdpath("config")) })

      opts.formatting = vim.tbl_deep_extend("force", opts.formatting, {
        format = function(entry, item)
          local lspkind_format = require("lspkind").cmp_format(opts.lspkind_opts)
          if type(opts.cmp_extra_format) == "function" then
            return lspkind_format(entry, opts.cmp_extra_format(entry, item))
          end
          return lspkind_format(entry, item)
        end,
      })

      opts.sources = cmp.config.sources(opts.cmp_sources)

      cmp.setup(require("ori.lib.utils.tbl").exclude(opts, opts.excluded_opts))
    end,
  },
}
