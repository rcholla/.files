return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  init = function()
    local handlers, icons = require("plugins.lsp.handlers"), require("extra.icons")

    local signs = {
      { name = "DiagnosticSignError", text = icons.diagnostics.Error },
      { name = "DiagnosticSignWarn", text = icons.diagnostics.Warn },
      { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
      { name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
    }
    for _, sign in pairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = { only_current_line = true },
      signs = { active = signs },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

    require("lspconfig.ui.windows").default_options.border = "rounded"

    for _, server in pairs({
      "nil_ls",
      "bashls",
      "lua_ls",
      "html",
      "cssls",
      "tailwindcss",
      "emmet_language_server",
      "tsserver",
      "svelte",
      "jsonls",
      "yamlls",
      "taplo",
      "marksman",
      "gopls",
      "rust_analyzer",
      "hls",
      "sqls",
    }) do
      if server == "rust_analyzer" or server == "hls" then
        goto continue
      end

      local opts = { capabilities = handlers.capabilities, on_attach = handlers.on_attach }
      local server_opts_ok, server_opts = pcall(require, ("plugins.lsp.servers.%s"):format(server))
      if server_opts_ok then
        opts = vim.tbl_deep_extend("force", opts, server_opts)
      end

      require("lspconfig")[server].setup(opts)
      ::continue::
    end
  end,
}
