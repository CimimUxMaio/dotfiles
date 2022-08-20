local utils = require("utils")

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    utils.warn_module_import_fail("telescope")
    return
end


local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
            }
        }
    }
})


vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>P", "<cmd>Telescope commands<CR>", { noremap = true, silent = true })



