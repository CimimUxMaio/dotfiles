local _M = {}

function _M.setup()
  require("hop").setup()

  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "s", ":HopChar1<CR>", opts)
end

return _M
