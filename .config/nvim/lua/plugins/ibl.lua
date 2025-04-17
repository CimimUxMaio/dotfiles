return {
  "lukas-reineke/indent-blankline.nvim",

  name = "ibl",

  init = function()
    local hooks = require("ibl.hooks")
    -- This hook makes the highlight groups to be reset every time the color scheme is changed
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#707070" })
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#303030" })
    end)
  end,
}
