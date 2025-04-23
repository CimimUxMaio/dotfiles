local function diagnostics_setup()
  local signs = {
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignDebug", text = "" },
    { name = "DiagnosticSignTrace", text = "✎" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    severity_sort = true,
    float = {
      focusable = false,
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)
end

local function set_highlight_on_hover(bufnr)
  -- LspReferenceText, LspReferenceRead, LspReferenceWrite highlight groups
  -- are used and should be defined.
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

local function set_buf_lsp_keymaps(client, bufnr)
  local opts = { noremap = true, silent = true }

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "ge", ":lua vim.diagnostic.setloclist()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", ",", ":lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", ".", ":lua vim.lsp.buf.hover({border = 'rounded'})<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)

  if client.server_capabilities.renameProvider then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>R", ":lua vim.lsp.buf.rename()<CR>", opts)
  end

  vim.api.nvim_buf_set_keymap(bufnr, "n", "dk", ":lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "dj", ":lua vim.diagnostic.goto_next()<CR>", opts)
end

local function on_lsp_attach(client, bufnr)
  set_buf_lsp_keymaps(client, bufnr)

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

    require("mason").setup {
      ui = {
        border = "rounded",
      },
    }

    require("mason-lspconfig").setup()
    lsp_config_setup()
  end,
}
