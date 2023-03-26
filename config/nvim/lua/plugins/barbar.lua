-- See `github.com/romgrk/barbar.nvim` for mor useful commands.

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "H", ":BufferPrevious<CR>", opts)
vim.api.nvim_set_keymap("n", "L", ":BufferNext<CR>", opts)
vim.api.nvim_set_keymap("n", "Q", ":BufferClose<CR>", opts)


local current_buffer
local previous_buffer

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(event)
    if vim.api.nvim_buf_get_option(event.buf, "buflisted") then
      previous_buffer = current_buffer
      current_buffer = event.file
    end
  end,
  group = vim.api.nvim_create_augroup("BarbarConfig", { clear = false })
})

vim.api.nvim_create_user_command(
  "BufferReplace",
  function(params)
    vim.cmd.edit(params.args)
    if previous_buffer then
      vim.cmd.BufferClose(previous_buffer)
      previous_buffer = nil
    end
  end,
  { nargs = 1, complete = "file", force = true }
)

require("bufferline").setup {
  animation = false,
  insert_at_end = true
}
