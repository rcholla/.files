return {
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

    require("luasnip/loaders/from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").load({ paths = ("%s/lua/plugins/snippets"):format(vim.fn.stdpath("config")) })

    return {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-A-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-A-j>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = require("lspkind").cmp_format({
          mode = "symbol",
          maxwidth = 50,
          show_labelDetails = true,
          before = function(entry, item)
            item.menu = ({
              nvim_lsp = ">- LSP",
              nvim_lua = ">- Lua",
              luasnip = ">- Snippet",
              crates = ">- Crates",
              path = ">- Path",
            })[entry.source.name]

            return require("tailwind-tools.cmp").lspkind_format(entry, item)
          end,
        }),
      },
      sources = {
        { name = "nvim_lsp", trigger_characters = { "-" } },
        { name = "nvim_lua" },
        { name = "luasnip", max_item_count = 10 },
        { name = "crates" },
        { name = "path" },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = { ghost_text = true },
    }
  end,
}
