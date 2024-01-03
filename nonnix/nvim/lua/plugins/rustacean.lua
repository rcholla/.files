return {
  "mrcjkb/rustaceanvim",
  ft = "rust",
  init = function()
    local codelldb_path = os.getenv("NVIM_DBG_CODELLDB")
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
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities,
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
}
