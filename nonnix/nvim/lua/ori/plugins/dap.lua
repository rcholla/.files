return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = {
      integrations = { dap = { enabled = true, enable_ui = true } },
    },
  },
  {
    "mfussenegger/nvim-dap",
    main = "dap",
    keys = {
      {
        "<C-A-d>",
        function()
          require("dap").continue()
        end,
      },
    },
    config = function()
      local icons = require("ori.lib.icons")

      for _, sign in pairs({
        { name = "DapBreakpoint", text = icons.dap.Breakpoint },
        { name = "DapStopped", text = icons.dap.Stopped },
        { name = "DapBreakpointCondition", text = icons.dap.BreakpointCondition },
        { name = "DapLogPoint", text = icons.dap.LogPoint },
      }) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name, linehl = "" })
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    main = "dapui",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup(opts)

      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close
    end,
  },
  {
    "LiadOz/nvim-dap-repl-highlights",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPost",
    keys = {
      {
        "<C-b>",
        function()
          require("persistent-breakpoints.api").toggle_breakpoint()
        end,
        mode = { "n", "i" },
      },
    },
    dependencies = "mfussenegger/nvim-dap",
    opts = { load_breakpoints_event = { "BufReadPost" } },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = vim.list_extend(opts.spec or {}, {
        { "<leader>d", group = "DAP" },
        {
          "<leader>db",
          ":lua require('persistent-breakpoints.api').toggle_breakpoint()<CR>",
          desc = "Toggle breakpoint",
        },
        {
          "<leader>dc",
          ":lua require('persistent-breakpoints.api').clear_all_breakpoints()<CR>",
          desc = "Clear breakpoints",
        },
        {
          "<leader>dC",
          ":lua require('persistent-breakpoints.api').set_conditional_breakpoint()<CR>",
          desc = "Set conditional breakpoint",
        },
        { "<leader>dh", ":lua require('dap').continue()<CR>", desc = "Continue" },
        { "<leader>dk", ":lua require('dap').step_out()<CR>", desc = "Step out" },
        { "<leader>dl", ":lua require('dap').step_into()<CR>", desc = "Step into" },
        { "<leader>dj", ":lua require('dap').step_over()<CR>", desc = "Step over" },
        { "<leader>d_", ":lua require('dap').run_last()<CR>", desc = "Run last" },
        { "<leader>du", ":lua require('dapui').toggle()<CR>", desc = "DAP UI" },
        { "<leader>ds", ":lua require('dapui').float_element('scopes')<CR>", desc = "Scopes" },
        { "<leader>dS", ":lua require('dapui').float_element('stacks')<CR>", desc = "Stacks" },
        { "<leader>dw", ":lua require('dapui').float_element('watches')<CR>", desc = "Watches" },
        { "<leader>dB", ":lua require('dapui').float_element('breakpoints')<CR>", desc = "Breakpoints" },
        { "<leader>dr", ":lua require('dapui').float_element('repl')<CR>", desc = "Repl" },
        {
          "<leader>de",
          ":lua require('dap').set_exception_breakpoints({ 'all' })<CR>",
          desc = "Set exception breakpoints",
        },
      })
    end,
  },
}
