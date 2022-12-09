local com_utils = require("Comment.utils")
local ctx_cstr_utils = require("ts_context_commentstring.utils")
local ctx_cstr_internal = require("ts_context_commentstring.internal")

require("Comment").setup {
    ignore = "^$",  -- Ignore empty lines.

    pre_hook = function(ctx)
        local location = nil
        if ctx.ctype == com_utils.ctype.block then
            location = ctx_cstr_utils.get_cursor_location()
        elseif ctx.cmotion == com_utils.cmotion.v or ctx.cmotion == com_utils.cmotion.V then
            location = ctx_cstr_utils.get_visual_start_location()
        end

        return ctx_cstr_internal.calculate_commentstring {
            key = ctx.ctype == com_utils.ctype.line and "__default" or "__multiline",
            location = location
        }
    end
}
