return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = function(_, opts)
      opts.integrations = vim.tbl_deep_extend("force", opts.integrations, {
        native_lsp = { enabled = true, inlay_hints = { background = true } },
        semantic_tokens = true,
        navic = { enabled = true, custom_bg = opts.C.color24 },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function(_, opts)
      local handlers, icons = require("ori.plugins.lsp.handlers"), require("ori.lib.icons")

      local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warn },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
      }
      for _, sign in pairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end

      vim.diagnostic.config({
        virtual_text = false,
        signs = { active = signs },
        update_in_insert = true,
        severity_sort = true,
        underline = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = true,
          header = "",
          prefix = "",
        },
      })

      require("lspconfig.ui.windows").default_options.border = "rounded"

      for server, server_opts in pairs(opts.servers) do
        require("lspconfig")[server].setup(vim.tbl_deep_extend("force", {
          capabilities = handlers.capabilities,
          on_attach = handlers.on_attach,
        }, server_opts))
      end
    end,
  },
  {
    "VidocqH/lsp-lens.nvim",
    event = "VeryLazy",
    keys = { { "<C-;>", "<CMD>LspLensToggle<CR>" } },
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      enable = true,
      include_declaration = true,
      sections = {
        definition = true,
        references = true,
        implements = true,
      },
    },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "VeryLazy",
    dependencies = "neovim/nvim-lspconfig",
    keys = function()
      local active = true
      local function toggle_lsplines()
        vim.diagnostic.config(active and { virtual_lines = false } or { virtual_lines = { only_current_line = true } })
        active = not active
      end

      return { { "<C-'>", toggle_lsplines } }
    end,
    config = function(_, opts)
      vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

      require("lsp_lines").setup(opts)
    end,
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      highlight = true,
      separator = " / ",
    },
  },
}
