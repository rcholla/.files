return function(dap)
  dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = { ("%s/dist/adapter.bundle.js"):format(os.getenv("NVIM_DBG_FIREFOX")) },
  }

  for _, language in pairs({ "javascript", "typescript" }) do
    dap.configurations[language] = {
      {
        name = "Debug with Firefox",
        type = "firefox",
        request = "launch",
        reAttach = true,
        url = "http://localhost:8525",
        webRoot = "${workspaceFolder}",
        firefoxExecutable = os.getenv("NVIM_FIREFOX_EXECUTABLE"),
      },
    }
  end
end
