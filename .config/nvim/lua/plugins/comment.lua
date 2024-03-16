local _M = {}

return {
  "numToStr/Comment.nvim",

  name = "comment",

  dependencies = { "treesitter", "JoosepAlviste/nvim-ts-context-commentstring" },

  config = function()
    vim.g.skip_ts_context_commentstring_module = true

    require("Comment").setup {
      ignore = "^$", -- Ignore empty lines.
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
}
