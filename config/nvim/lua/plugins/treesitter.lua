local _M = {}

function _M.setup()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		ensure_installed = { "lua", "vim", "vimdoc", "python" },
		sync_install = false,
		ignore_install = { "" },
		highlight = {
			enable = true,
			disable = {},
			aditional_vim_regex_highlighting = true,
		},

		indent = { enable = true, disable = {} },

		autotag = {
			enable = true,
		},

		refactor = {
			smart_rename = {
				enable = true,
				keymaps = {
					smart_rename = "<leader>r",
				},
			},
		},
	})

	-- Enable code folding using treesitter
	local opt = vim.opt

	opt.foldlevel = 20
	opt.foldmethod = "expr"
	opt.foldexpr = "nvim_treesitter#foldexpr()"
end

return _M
