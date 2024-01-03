return {
  "mfussenegger/nvim-dap",
  main = "dap",
  keys = {
    {
      "<C-A-d>",
      function()
        require("dap").continue()
      end,
    },
    {
      "<C-b>",
      function()
        require("persistent-breakpoints.api").toggle_breakpoint()
      end,
      mode = { "n", "i" },
    },
  },
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      main = "dapui",
      config = function(_, opts)
        local dap, dapui = require("dap"), require("dapui")

        dapui.setup(opts)

        dap.listeners.before.attach.dapui_config = dapui.open
        dap.listeners.before.launch.dapui_config = dapui.open
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close
      end,
    },
    { "LiadOz/nvim-dap-repl-highlights", config = true },
    { "Weissle/persistent-breakpoints.nvim", opts = { load_breakpoints_event = { "BufReadPost" } } },
  },
  config = function(_, _)
    local icons = require("extra.icons")

    for _, sign in pairs({
      { name = "DapBreakpoint", text = icons.dap.Breakpoint },
      { name = "DapStopped", text = icons.dap.Stopped },
      { name = "DapBreakpointCondition", text = icons.dap.BreakpointCondition },
      { name = "DapLogPoint", text = icons.dap.LogPoint },
    }) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name, linehl = "" })
    end

    for _, adapter in pairs({ "firefox", "go", "rust", "haskell" }) do
      local adapter_setup_ok, adapter_setup = pcall(require, ("plugins.dap.adapters.%s"):format(adapter))
      if adapter_setup_ok then
        adapter_setup(require("dap"))
      end
    end
  end,
}
