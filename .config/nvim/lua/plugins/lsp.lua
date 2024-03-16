local function diagnostics_setup()
  local sign_icons = {
    Hint = "",
    Info = "",
    Warn = "",
    Error = "",
    Debug = "",
    Trace = "✎",
  }

  local signs = {
    { name = "DiagnosticSignError", text = sign_icons.Error },
    { name = "DiagnosticSignWarn", text = sign_icons.Warn },
    { name = "DiagnosticSignHint", text = sign_icons.Hint },
    { name = "DiagnosticSignInfo", text = sign_icons.Info },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function set_highlight_on_hover(bufnr)
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

local function set_lsp_keymaps(client, bufnr)
  local opts = { noremap = true, silent = true }

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "ge", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", ",", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", ".", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  if client.server_capabilities.renameProvider then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  end

  vim.api.nvim_buf_set_keymap(bufnr, "n", "dk", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "dj", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
end

local function on_lsp_attach(client, bufnr)
  set_lsp_keymaps(client, bufnr)

  if client.supports_method("textDocument/documentHighlight") then
    set_highlight_on_hover(bufnr)
  end
end

local function lsp_config_setup()
  require("mason-lspconfig").setup_handlers {
    function(server_name)
      require("lspconfig")[server_name].setup {
        on_attach = on_lsp_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }
    end,
  }
end

return {
  "williamboman/mason.nvim",

  name = "mason",

  dependencies = {
    "hrsh7th/nvim-cmp",
    "williamboman/mason-lspconfig",
    "neovim/nvim-lspconfig",
    "dressing",
  },

  config = function()
    diagnostics_setup()
    require("mason").setup()
    require("mason-lspconfig").setup()
    lsp_config_setup()
  end,
}
