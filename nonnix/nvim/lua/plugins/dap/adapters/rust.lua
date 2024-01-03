return function(dap)
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = ("%s/adapter/codelldb"):format(os.getenv("NVIM_DBG_CODELLDB")),
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
end
