local M = {}

M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities({
    dynamicRegistration = true,
  }),
  {} -- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/protocol.lua
)

---@param client lsp.Client
---@param bufnr number
function M.on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  if client.server_capabilities.inlayHintProvider then
    require("lsp-inlayhints").on_attach(client, bufnr)
  end
end

return M
