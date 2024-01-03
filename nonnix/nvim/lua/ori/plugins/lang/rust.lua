return {
  {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    config = function()
      local handlers = require("ori.plugins.lsp.handlers")

      local codelldb_path = os.getenv("USERENV_DBG_CODELLDB")
      local adapter_path, liblldb_path =
        ("%s/adapter/codelldb"):format(codelldb_path), ("%s/lldb/lib/liblldb.so"):format(codelldb_path)

      vim.g.rust_recommended_style = false
      vim.g.rustaceanvim = {
        tools = {
          on_initialized = function()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave", "BufWritePost" }, {
              pattern = "*.rs",
              callback = vim.lsp.codelens.refresh,
            })
          end,
          inlay_hints = { auto = false },
        },
        server = {
          on_attach = handlers.on_attach,
          capabilities = handlers.capabilities,
          settings = {
            ["rust-analyzer"] = {
              lens = { enable = true },
              checkOnSave = { command = "clippy" },
              inlayHints = { locationLinks = false },
            },
          },
        },
        dap = { adapter = require("rustaceanvim.config").get_codelldb_adapter(adapter_path, liblldb_path) },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        taplo = {},
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = ("%s/adapter/codelldb"):format(os.getenv("USERENV_DBG_CODELLDB")),
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", ("%s/"):format(vim.fn.getcwd()), "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
        },
      }
    end,
  },
  {
    "nvimdev/guard.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ft = vim.list_extend(opts.ft, {
        { "rust", fmt = "lsp" },
        { "toml", fmt = "taplo" },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = "rouge8/neotest-rust",
    opts = function()
      return { adapters = { require("neotest-rust") } }
    end,
  },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        optional = true,
        opts = function(_, opts)
          opts.cmp_sources = vim.list_extend(opts.cmp_sources, {
            { name = "crates" },
          })

          opts.lspkind_opts = vim.tbl_deep_extend("force", opts.lspkind_opts, {
            menu = { crates = ">- Crates" },
          })
        end,
      },
    },
    config = true,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      binds = {
        n = {
          r = {
            name = "Rust",
            r = { ":RustLsp runnables<CR>", "Runnables" },
            d = { ":RustLsp debuggables<CR>", "Debuggables" },
            m = { ":RustLsp expandMacro<CR>", "Expand macro" },
            M = { ":RustLsp rebuildProcMacros<CR>", "Rebuild proc macros" },
            a = { ":RustLsp hover actions<CR>", "Hover actions" },
            e = { ":RustLsp explainError<CR>", "Explain error" },
            c = { ":RustLsp openCargo<CR>", "Open Cargo.toml" },
            p = { ":RustLsp parentModule<CR>", "Parent module" },
            s = { ":RustLsp ssr<CR>", "Structural search replace" },
            g = { ":RustLsp crateGraph<CR>", "Crate graph" },
            t = { ":RustLsp syntaxTree<CR>", "Syntax tree" },
            f = { ":RustLsp flyCheck<CR>", "Fly check" },
          },
        },
      },
    },
  },
}
