local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    sources = {
        formatting.black,
        formatting.eslint,

        diagnostics.flake8,
        diagnostics.eslint,
        diagnostics.misspell,

        code_actions.eslint,
    }
})

_G.format_on_save = false  -- By default disable auto formatting
function _G.toggle_format_on_save()
    _G.format_on_save = not _G.format_on_save
    if (not _G.format_on_save) then
        vim.cmd("autocmd! FormatOnSave")
    else
        vim.cmd [[
            augroup FormatOnSave
                au!
                autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
            augroup END
        ]]
    end
    vim.notify("Format on save set to: " .. tostring(_G.format_on_save), "info", { title = "Format on Save" })
end

vim.cmd("command -nargs=0 ToggleFormatOnSave lua toggle_format_on_save()")
