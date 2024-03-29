local _M = {}

function _M.setup()
  local utils = require("utils")
  local notify = require("notify")

  vim.notify = notify

  local signs = utils.icons.signs

  notify.setup({
    -- Animation style (see below for details)
    stages = "slide",

    -- Function called when a new window is opened, use for changing win settings/config
    on_open = nil,

    -- Function called when a window is closed
    on_close = nil,

    -- Render function for notifications. See notify-render()
    render = "default",

    -- Default timeout for notifications
    timeout = 3000,

    -- Max number of columns for messages
    max_width = 60,
    -- Max number of lines for a message
    max_height = nil,

    -- For stages that change opacity this is treated as the highlight behind the window
    -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
    background_colour = "Normal",

    -- Minimum width for notification windows
    minimum_width = 40,

    -- Icons for the different levels
    icons = {
      INFO = signs.Info,
      HINT = signs.Hint,
      ERROR = signs.Error,
      TRACE = signs.Trace,
      WARN = signs.Warn,
      DEBUG = signs.Debug
    },
  })



  -- Highlights

  vim.cmd [[
      highlight NotifyERRORBorder  guifg=#8A1F1F
      highlight NotifyWARNBorder  guifg=#79491D
      highlight NotifyINFOBorder  guifg=#4F6752
      highlight NotifyDEBUGBorder  guifg=#8B8B8B
      highlight NotifyTRACEBorder  guifg=#4F3552
      highlight NotifyERRORIcon  guifg=#F70067
      highlight NotifyWARNIcon  guifg=#F79000
      highlight NotifyINFOIcon  guifg=#A9FF68
      highlight NotifyDEBUGIcon  guifg=#8B8B8B
      highlight NotifyTRACEIcon  guifg=#D484FF
      highlight NotifyERRORTitle  guifg=#F70067
      highlight NotifyWARNTitle  guifg=#F79000
      highlight NotifyINFOTitle  guifg=#A9FF68
      highlight NotifyDEBUGTitle  guifg=#8B8B8B
      highlight NotifyTRACETitle  guifg=#D484FF
      highlight link NotifyERRORBody Normal
      highlight link NotifyWARNBody Normal
      highlight link NotifyINFOBody Normal
      highlight link NotifyDEBUGBody Normal
      highlight link NotifyTRACEBody Normal
  ]]
end

return _M
