return {
	{
		"lunarvim/darkplus.nvim",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme darkplus]])
		end,
	},

	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	{ "stevearc/dressing.nvim", name = "dressing", lazy = true },

	"https://tpope.io/vim/fugitive.git",

	"christoomey/vim-tmux-navigator",
}
