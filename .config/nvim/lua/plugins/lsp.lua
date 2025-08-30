local function diagnostics_setup()
  local signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  }

  local config = {
    severity_sort = true,
    float = {
      focusable = false,
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
    signs = signs,
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
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<C-o>", opts) -- Go to previous cursor jump

  vim.api.nvim_buf_set_keymap(bufnr, "n", ",", ":lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", ".", ":lua vim.lsp.buf.hover({border = 'rounded'})<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)

  if client.server_capabilities.renameProvider then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>R", ":lua vim.lsp.buf.rename()<CR>", opts)
  end

  vim.api.nvim_buf_set_keymap(bufnr, "n", "dk", ":lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "dj", ":lua vim.diagnostic.goto_next()<CR>", opts)
end

return {
  "williamboman/mason-lspconfig",

  dependencies = {
    "neovim/nvim-lspconfig",
    { "williamboman/mason.nvim", opts = {} },
    "hrsh7th/nvim-cmp",
  },

  opts = {
    automatic_enable = true,
  },

  init = function()
    diagnostics_setup()

    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = function(client, bufnr)
        set_buf_lsp_keymaps(client, bufnr)

        if client:supports_method("textDocument/documentHighlight") then
          set_highlight_on_hover(bufnr)
        end
      end,
    })
  end,
}
