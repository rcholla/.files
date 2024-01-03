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
    "rcholla/guard.nvim",
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
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>r", group = "Rust" },
        { "<leader>rr", ":RustLsp runnables<CR>", desc = "Runnables" },
        { "<leader>rd", ":RustLsp debuggables<CR>", desc = "Debuggables" },
        { "<leader>rm", ":RustLsp expandMacro<CR>", desc = "Expand macro" },
        { "<leader>rM", ":RustLsp rebuildProcMacros<CR>", desc = "Rebuild proc macros" },
        { "<leader>ra", ":RustLsp hover actions<CR>", desc = "Hover actions" },
        { "<leader>re", ":RustLsp explainError<CR>", desc = "Explain error" },
        { "<leader>rc", ":RustLsp openCargo<CR>", desc = "Open Cargo.toml" },
        { "<leader>rp", ":RustLsp parentModule<CR>", desc = "Parent module" },
        { "<leader>rs", ":RustLsp ssr<CR>", desc = "Structural search replace" },
        { "<leader>rg", ":RustLsp crateGraph<CR>", desc = "Crate graph" },
        { "<leader>rt", ":RustLsp syntaxTree<CR>", desc = "Syntax tree" },
        { "<leader>rf", ":RustLsp flyCheck<CR>", desc = "Fly check" },
      })
    end,
  },
}
