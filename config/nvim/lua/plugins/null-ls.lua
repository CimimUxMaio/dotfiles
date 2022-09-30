local utils = require("utils")

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    utils.warn_module_import_fail("null-ls")
    return
end


local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        formatting.black,

        diagnostics.flake8,
        diagnostics.misspell
    }
})


function _G.set_format_on_save()
    vim.cmd [[ autocmd! BufWritePre * execute 'Format' ]]
end

vim.cmd("command -nargs=0 SetFormatOnSave lua set_format_on_save()")
