return function(dap)
  dap.adapters.go = {
    type = "executable",
    command = "node",
    args = { ("%s/dist/debugAdapter.js"):format(os.getenv("NVIM_DBG_GO")) },
  }

  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      showLog = false,
      program = "${file}",
      dlvToolPath = ("%s/bin/dlv"):format(os.getenv("NVIM_DBG_DELVE")),
    },
  }
end
