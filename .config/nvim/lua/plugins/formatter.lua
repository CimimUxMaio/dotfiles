return {
	setup = function()
		local formatters = function(lang)
			return require(string.format("formatter.filetypes.%s", lang))
		end

		require("formatter").setup({
			filetype = {
				lua = { formatters("lua").stylua },

				javascript = { formatters("javascript").eslint_d },
				javascriptreact = { formatters("javascriptreact").eslint_d },
				typescript = { formatters("typescript").eslint_d },
				typescriptreact = { formatters("typescriptreact").eslint_d },

				python = { formatters("python").black },

				["*"] = { formatters("any").remove_trailing_whitespace },
			},
		})

		vim.api.nvim_create_autocmd({ "BufWritePost" }, { command = "FormatWrite" })
	end,
}
