return {
  "stevearc/conform.nvim",

  name = "conform",

  opts = {
    formatters_by_ft = {
      -- Conform will run multiple formatters sequentially
      -- Use a sub-list to run only the first available formatter

      lua = { "stylua" },
      python = { "black", "autopep8" },

      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },

      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },

      go = { "goimports" },

      rust = { "rustfmt" },

      elixir = { "mix" },

      css = { "prettierd" },

      ["_"] = { "trim_whitespace" },
    },

    format_on_save = function()
      if not vim.g.format_on_save then
        return
      end
      return { timeout_ms = 2000, lsp_format = "fallback", stop_after_first = true }
    end,
  },

  init = function()
    -- Format on save active by default
    vim.g.format_on_save = true

    vim.api.nvim_create_user_command("FormatToggle", function()
      vim.g.format_on_save = not vim.g.format_on_save
      vim.notify("Format on save " .. (vim.g.format_on_save and "enabled" or "disabled"))
    end, {
      desc = "Enable / Disable format on save",
    })
  end,
}
