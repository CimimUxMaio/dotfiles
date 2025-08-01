return {
  "mfussenegger/nvim-lint",

  name = "nvim-lint",

  init = function()
    require("lint").linters_by_ft = {
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },

      python = { "flake8" },

      lua = { "selene" },

      go = { "golangcilint" },

      rust = { "clippy" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint(nil, { ignore_errors = true })
      end,
    })
  end,
}
