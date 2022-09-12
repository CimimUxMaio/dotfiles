local utils = require("utils")

local status_ok, hop = pcall(require, "hop")
if not status_ok then
    utils.warn_module_import_fail("hop")
    return
end

hop.setup()

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "s", ":HopChar1<CR>", opts)
