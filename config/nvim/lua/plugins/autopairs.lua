local _M = {}

function _M.setup()
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")

  require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
  require("nvim-autopairs").setup {}
end

return _M
