return {
  {
    "mrcjkb/haskell-tools.nvim",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      vim.g.haskell_tools = {
        hls = {
          on_attach = function(client, bufnr, _)
            require("ori.plugins.lsp.handlers").on_attach(client, bufnr)
          end,
          settings = {
            haskell = {
              formattingProvider = "ormolu",
            },
          },
        },
        dap = { auto_discover = false },
        tools = { tags = { enable = false } },
      }

      require("ori.lib.utils.lazy").on_load("telescope.nvim", function()
        require("telescope").load_extension("ht")
      end)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      dap.adapters.haskell = {
        type = "executable",
        command = "haskell-debug-adapter",
        args = { "--hackage-version=0.0.33.0" },
      }

      dap.configurations.haskell = {
        {
          type = "haskell",
          request = "launch",
          name = "Debug",
          workspace = "${workspaceFolder}",
          startup = "${file}",
          stopOnEntry = true,
          logFile = ("%s/haskell-dap.log"):format(vim.fn.stdpath("data")),
          logLevel = "WARNING",
          ghciEnv = vim.empty_dict(),
          ghciPrompt = "λ ",
          ghciInitialPrompt = "λ ",
          ghciCmd = "ghci-dap --interactive -i ${workspaceFolder}",
        },
      }
    end,
  },
  {
    "nvimdev/guard.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ft = vim.list_extend(opts.ft, {
        { "haskell", fmt = "lsp" },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = "mrcjkb/neotest-haskell",
    opts = function()
      return { adapters = { require("neotest-haskell") } }
    end,
  },
  {
    "Vigemus/iron.nvim",
    optional = true,
    dependencies = "mrcjkb/haskell-tools.nvim",
    opts = {
      config = {
        repl_definition = {
          haskell = {
            command = function(meta)
              return require("haskell-tools").repl.mk_repl_cmd(vim.api.nvim_buf_get_name(meta.current_bufnr))
            end,
          },
        },
      },
    },
  },
  {
    "luc-tielen/telescope_hoogle",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      require("ori.lib.utils.lazy").on_load("telescope.nvim", function()
        require("telescope").load_extension("hoogle")
      end)
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      binds = {
        n = {
          h = {
            name = "Haskell",
            e = { ":lua require('haskell-tools').lsp.buf_eval_all()<CR>", "Evaluate all" },
            h = { ":lua require('haskell-tools').hoogle.hoogle_signature()<CR>", "Hoogle signature" },
            R = { ":lua require('haskell-tools').repl.toggle()<CR>", "Repl" },
            t = { ":lua require('haskell-tools').tags.generate_project_tags()<CR>", "Generate project tags" },
            T = { ":lua require('haskell-tools').tags.generate_package_tags()<CR>", "Generate package tags" },
            l = {
              name = "LSP",
              s = { ":lua require('haskell-tools').lsp.start()<CR>", "Start LSP client" },
              S = { ":lua require('haskell-tools').lsp.stop()<CR>", "Stop LSP client" },
              r = { ":lua require('haskell-tools').lsp.restart()<CR>", "Restart LSP client" },
            },
            r = {
              name = "Repl",
              r = { ":lua require('haskell-tools').repl.reload()<CR>", "Reload repl" },
              q = { ":lua require('haskell-tools').repl.quit()<CR>", "Quit repl" },
              T = { ":lua require('haskell-tools').repl.cword_type()<CR>", "Query type" },
              i = { ":lua require('haskell-tools').repl.cword_info()<CR>", "Query info" },
            },
            p = {
              name = "Project",
              f = { ":lua require('haskell-tools').project.open_project_file()<CR>", "Open project file" },
              y = { ":lua require('haskell-tools').project.open_package_yaml()<CR>", "Open package.yaml" },
              c = { ":lua require('haskell-tools').project.open_package_cabal()<CR>", "Open *.cabal" },
              t = { ":lua require('haskell-tools').project.telescope_package_files()<CR>", "Search files" },
              T = { ":lua require('haskell-tools').project.telescope_package_grep()<CR>", "Live grep" },
            },
          },
        },
      },
    },
  },
}
