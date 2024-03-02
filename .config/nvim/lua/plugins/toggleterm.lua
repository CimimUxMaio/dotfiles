local _M = {}

function _M.setup()
	require("toggleterm").setup({
		size = 15,
		-- open_mapping = "|",
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = false,
		persist_size = true,
		-- direction = "horizontal",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	})

	local keymap_opts = { noremap = true, silent = true }
	local Terminal = require("toggleterm.terminal").Terminal

	local float_term = Terminal:new({
		hidden = true,
		direction = "float",
		on_open = function(term)
			-- Set terminal disable keymap
			vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], keymap_opts)

			-- Set terminal close keymap
			vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<M-t>", "<cmd>close<CR>", keymap_opts)
		end,
	})

	vim.api.nvim_create_user_command("ToggleTermFloat", function()
		float_term:toggle()
	end, {
		desc = "Toggle float terminal",
	})

	vim.api.nvim_set_keymap("n", "<M-t>", ":ToggleTermFloat<CR>", keymap_opts)
end

return _M
