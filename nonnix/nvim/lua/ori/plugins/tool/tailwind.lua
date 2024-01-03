return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        tailwindcss = {
          root_dir = require("lspconfig.util").root_pattern("tailwind.config.js", "tailwind.config.ts"),
          fileypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
        },
      },
    },
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        optional = true,
        opts = function(_, opts)
          local prev_fn = opts.cmp_extra_format
          opts.cmp_extra_format = function(entry, item)
            if type(prev_fn) == "function" then
              return require("tailwind-tools.cmp").lspkind_format(entry, prev_fn(entry, item))
            end
            return require("tailwind-tools.cmp").lspkind_format(entry, item)
          end
        end,
      },
    },
    opts = {
      document_color = {
        enabled = true,
        kind = "background",
      },
    },
  },
  {
    "MaximilianLloyd/tw-values.nvim",
    keys = { { "<C-A-t>", "<CMD>TWValues<CR>", mode = { "n", "i" } } },
    opts = {
      border = "rounded",
      show_unknown_classes = true,
      focus_preview = true,
    },
  },
}
