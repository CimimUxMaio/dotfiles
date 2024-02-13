local _M = {}

function _M.setup()
  require("scrollbar").setup({
    handle = {
      color = "#BBBBBB"
    }
  })

  require("scrollbar.handlers.search").setup()
end

return _M
