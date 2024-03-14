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

	vim.api.nvim_buf_set_keymap(bufnr, "n", "F", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

	if client.server_capabilities.renameProvider then
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end

	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	vim.api.nvim_buf_set_keymap(bufnr, "n", "dk", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "dj", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
end

local function on_lsp_attach(client, bufnr)
	set_lsp_keymaps(client, bufnr)

	if client.supports_method("textDocument/documentHighlight") then
		set_highlight_on_hover(bufnr)
	end
end

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_lsp_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
})
