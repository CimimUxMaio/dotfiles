local _M = {}

function _M.setup()
  require("Comment").setup {
    ignore = "^$", -- Ignore empty lines.

    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
  }
end

return _M
