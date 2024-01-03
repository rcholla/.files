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
    "rcholla/guard.nvim",
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
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>h", group = "Haskell" },
        { "<leader>he", ":lua require('haskell-tools').lsp.buf_eval_all()<CR>", desc = "Evaluate all" },
        { "<leader>hh", ":lua require('haskell-tools').hoogle.hoogle_signature()<CR>", desc = "Hoogle signature" },
        { "<leader>hR", ":lua require('haskell-tools').repl.toggle()<CR>", desc = "Repl" },
        {
          "<leader>ht",
          ":lua require('haskell-tools').tags.generate_project_tags()<CR>",
          desc = "Generate project tags",
        },
        {
          "<leader>hT",
          ":lua require('haskell-tools').tags.generate_package_tags()<CR>",
          desc = "Generate package tags",
        },
        { "<leader>hl", group = "LSP" },
        { "<leader>hls", ":lua require('haskell-tools').lsp.start()<CR>", desc = "Start LSP client" },
        { "<leader>hlS", ":lua require('haskell-tools').lsp.stop()<CR>", desc = "Stop LSP client" },
        { "<leader>hlr", ":lua require('haskell-tools').lsp.restart()<CR>", desc = "Restart LSP client" },
        { "<leader>hr", group = "Repl" },
        { "<leader>hrr", ":lua require('haskell-tools').repl.reload()<CR>", desc = "Reload repl" },
        { "<leader>hrq", ":lua require('haskell-tools').repl.quit()<CR>", desc = "Quit repl" },
        { "<leader>hrT", ":lua require('haskell-tools').repl.cword_type()<CR>", desc = "Query type" },
        { "<leader>hri", ":lua require('haskell-tools').repl.cword_info()<CR>", desc = "Query info" },
        { "<leader>hp", group = "Project" },
        {
          "<leader>hpf",
          ":lua require('haskell-tools').project.open_project_file()<CR>",
          desc = "Open project file",
        },
        {
          "<leader>hpy",
          ":lua require('haskell-tools').project.open_package_yaml()<CR>",
          desc = "Open package.yaml",
        },
        { "<leader>hpc", ":lua require('haskell-tools').project.open_package_cabal()<CR>", desc = "Open *.cabal" },
        {
          "<leader>hpt",
          ":lua require('haskell-tools').project.telescope_package_files()<CR>",
          desc = "Search files",
        },
        { "<leader>hpT", ":lua require('haskell-tools').project.telescope_package_grep()<CR>", desc = "Live grep" },
      })
    end,
  },
}
