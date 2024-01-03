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
    opts = {
      binds = {
        n = {
          d = {
            name = "DAP",
            b = { ":lua require('persistent-breakpoints.api').toggle_breakpoint()<CR>", "Toggle breakpoint" },
            c = { ":lua require('persistent-breakpoints.api').clear_all_breakpoints()<CR>", "Clear breakpoints" },
            -- stylua: ignore
            C = { ":lua require('persistent-breakpoints.api').set_conditional_breakpoint()<CR>", "Set conditional breakpoint" },
            h = { ":lua require('dap').continue()<CR>", "Continue" },
            k = { ":lua require('dap').step_out()<CR>", "Step out" },
            l = { ":lua require('dap').step_into()<CR>", "Step into" },
            j = { ":lua require('dap').step_over()<CR>", "Step over" },
            _ = { ":lua require('dap').run_last()<CR>", "Run last" },
            u = { ":lua require('dapui').toggle()<CR>", "DAP UI" },
            s = { ":lua require('dapui').float_element('scopes')<CR>", "Scopes" },
            S = { ":lua require('dapui').float_element('stacks')<CR>", "Stacks" },
            w = { ":lua require('dapui').float_element('watches')<CR>", "Watches" },
            B = { ":lua require('dapui').float_element('breakpoints')<CR>", "Breakpoints" },
            r = { ":lua require('dapui').float_element('repl')<CR>", "Repl" },
            e = { ":lua require('dap').set_exception_breakpoints({ 'all' })<CR>", "Set exception breakpoints" },
          },
        },
      },
    },
  },
}
