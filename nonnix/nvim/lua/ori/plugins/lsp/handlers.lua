local M = {}

---@type lsp.ClientCapabilities
M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities({
    dynamicRegistration = true,
  }),
  {} -- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/protocol.lua
)

---@type fun(client: vim.lsp.Client, bufnr: number)
function M.on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    local ok, nvim_navic = pcall(require, "nvim-navic")
    if ok then
      nvim_navic.attach(client, bufnr)
    end
  end

  if client.server_capabilities.inlayHintProvider then
    local function toggle_inlay_hints()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end
    toggle_inlay_hints()

    vim.keymap.set("n", "<C-i>", toggle_inlay_hints, { noremap = true, silent = true })
  end
end

return M
