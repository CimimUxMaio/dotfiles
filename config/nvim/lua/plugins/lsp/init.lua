local _M = {}

function _M.setup()
  require("plugins.lsp.diagnostics")
  require("mason").setup()
  require("mason-lspconfig").setup()
  require("plugins.lsp.client")
end

return _M
