local utils = require("utils")

local status_ok, barbar = pcall(require, "bufferline")
if not status_ok then
    utils.warn_module_import_fail("barbar")
    return
end

-- See `github.com/romgrk/barbar.nvim` for mor useful commands.

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "H", ":BufferPrevious<CR>", opts)
vim.api.nvim_set_keymap("n", "L", ":BufferNext<CR>", opts)
vim.api.nvim_set_keymap("n", "Q", ":BufferClose<CR>", opts)



-- Using default options
barbar.setup {
    animation = false
}
