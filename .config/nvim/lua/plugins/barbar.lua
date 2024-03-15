return {
	"romgrk/barbar.nvim",

	name = "barbar",

	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local opts = { noremap = true, silent = true }

		vim.api.nvim_set_keymap("n", "H", ":BufferPrevious<CR>", opts)
		vim.api.nvim_set_keymap("n", "L", ":BufferNext<CR>", opts)
		vim.api.nvim_set_keymap("n", "Q", ":BufferClose<CR>", opts)

		require("bufferline").setup({
			animation = false,
			insert_at_end = true,
		})
	end,
}
