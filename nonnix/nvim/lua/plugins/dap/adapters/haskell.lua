return function(dap)
  dap.adapters.haskell = {
    type = "executable",
    command = ("%s/bin/haskell-debug-adapter"):format(os.getenv("NVIM_DBG_HASKELL")),
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
      ghciCmd = "cabal exec -- ghci-dap --interactive -i ${workspaceFolder}",
    },
  }
end
