return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      custom_highlights = {
        PackageInfoUpToDateVersion = { default = true, link = "DiagnosticVirtualTextInfo" }, -- package-info.nvim
        PackageInfoOutdatedVersion = { default = true, link = "DiagnosticVirtualTextWarn" },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
    opts = function()
      return {
        on_attach = require("ori.plugins.lsp.handlers").on_attach,
        settings = {
          tsserver_file_preferences = {
            includeCompletionsForModuleExports = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        jsonls = {
          init_options = {
            provideFormatter = false,
          },
        },
        yamlls = {},
        svelte = {
          settings = {
            svelte = {
              plugin = {
                svelte = {
                  format = {
                    enable = false,
                  },
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "rcholla/guard.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ft = vim.list_extend(opts.ft, {
        {
          "html,css,scss,javascript,javascriptreact,typescript,typescriptreact,svelte,json,jsonc,yaml,markdown",
          fmt = {
            cmd = "prettierd",
            fname = true,
            stdin = true,
          },
        },
        { "javascript,javascriptreact,typescript,typescriptreact,svelte", lint = "eslint_d" },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = "marilari88/neotest-vitest",
    opts = function()
      return { adapters = { require("neotest-vitest") } }
    end,
  },
  {
    "vuki656/package-info.nvim",
    event = "BufRead package.json",
    opts = function()
      local icons = require("ori.lib.icons")

      return {
        package_manager = "pnpm",
        icons = {
          style = {
            up_to_date = icons.misc.UpToDate,
            outdated = icons.misc.Outdated,
          },
        },
      }
    end,
    config = function(_, opts)
      require("package-info").setup(opts)

      require("ori.lib.utils.lazy").on_load("telescope.nvim", function()
        require("telescope").load_extension("package_info")
      end)
    end,
  },
}
