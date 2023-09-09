local function lsp_highlight_document(bufnr)
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		buffer = bufnr,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ "CursorMoved" }, {
		buffer = bufnr,
		callback = vim.lsp.buf.clear_references,
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }

	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)

	vim.api.nvim_buf_set_keymap(bufnr, "n", "F", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local function lsp_attach(client, bufnr)
	client.server_capabilities.document_formatting = false

	lsp_keymaps(bufnr)
	lsp_highlight_document(bufnr)
end

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = lsp_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
})
