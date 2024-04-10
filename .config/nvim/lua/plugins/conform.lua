return {
  "stevearc/conform.nvim",

  name = "conform",

  config = function()
    -- Format on save active by default
    vim.g.format_on_save = true

    require("conform").setup {
      formatters_by_ft = {
        -- Conform will run multiple formatters sequentially
        -- Use a sub-list to run only the first available formatter

        lua = { "stylua" },
        python = { { "black", "autopep8" } },

        javascript = { { "eslint_d", "eslint" } },
        javascriptreact = { { "eslint_d", "eslint" } },
        typescript = { { "eslint_d", "eslint" } },
        typescriptreact = { { "eslint_d", "eslint" } },

        ["_"] = { "trim_whitespace" },
      },

      format_on_save = function()
        if not vim.g.format_on_save then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    }

    vim.api.nvim_create_user_command("FormatToggle", function()
      vim.g.format_on_save = not vim.g.format_on_save
      vim.notify("Format on save " .. (vim.g.format_on_save and "enabled" or "disabled"))
    end, {
      desc = "Enable / Disable format on save",
    })
  end,
}
