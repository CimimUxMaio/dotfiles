local _M = {}

function _M.setup()
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-c>"] = actions.close,
					["<C-s>"] = actions.select_vertical,
					["<C-h><C-s>"] = actions.select_horizontal,
				},
			},
		},
	})

	vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>?", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>P", "<cmd>Telescope commands<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>S", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
end

return _M
