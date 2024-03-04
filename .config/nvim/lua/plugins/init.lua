-- Bootstrap Lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Plugins

require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-refactor",
		},
		config = require("plugins.treesitter").setup,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = require("plugins.telescope").setup,
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("plugins.nvim-tree").setup,
	},

	{
		"rcarriga/nvim-notify",
		config = require("plugins.notify").setup,
	},

	{
		"lunarvim/darkplus.nvim",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme darkplus]])
		end,
	},

	"lukas-reineke/indent-blankline.nvim",

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			{ "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
		},
		config = require("plugins.completion").setup,
	},

	{
		"windwp/nvim-autopairs",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = require("plugins.autopairs").setup,
	},

	{
		"williamboman/mason.nvim",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"williamboman/mason-lspconfig",
			"neovim/nvim-lspconfig",
			"dressing",
		},
		config = require("plugins.lsp").setup,
	},

	{
		"akinsho/toggleterm.nvim",
		config = require("plugins.toggleterm").setup,
	},

	{
		"nvim-lualine/lualine.nvim",
		config = require("plugins.lualine").setup,
	},

	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("plugins.barbar").setup,
	},

	{ "stevearc/dressing.nvim", name = "dressing", lazy = true },

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
		end,
	},

	{
		"numToStr/Comment.nvim",
		dependencies = { "treesitter", "JoosepAlviste/nvim-ts-context-commentstring" },
		config = require("plugins.comments").setup,
	},

	{
		"kevinhwang91/nvim-hlslens",
		config = require("plugins.hlslens").setup,
	},

	{
		"petertriho/nvim-scrollbar",
		dependencies = { "kevinhwang91/nvim-hlslens" },
		config = require("plugins.scrollbar").setup,
	},

	{
		"phaazon/hop.nvim",
		config = require("plugins.hop").setup,
	},

	"https://tpope.io/vim/fugitive.git",

	{
		"lewis6991/gitsigns.nvim",
		config = require("plugins.gitsigns").setup,
	},

	{
		"mfussenegger/nvim-lint",
		config = require("plugins.linter").setup,
	},

	{
		"stevearc/conform.nvim",
		config = require("plugins.conform").setup,
	},

	{
		"zbirenbaum/copilot.lua",
		config = require("plugins.copilot").setup,
	},

	"christoomey/vim-tmux-navigator",
})
