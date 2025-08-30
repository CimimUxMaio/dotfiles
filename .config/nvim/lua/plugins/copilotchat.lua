return {
  "CopilotC-Nvim/CopilotChat.nvim",

  name = "copilot-chat",

  dependencies = {
    "copilot",
    "cmp",
    "dressing",
    { "nvim-lua/plenary.nvim" },
  },

  build = "make tiktoken",

  opts = {
    show_help = true,
    highlight_selection = false,
    chat_autocomplete = true,

    selection = function(source)
      local select = require("CopilotChat.select")
      return select.visual(source) or select.buffer(source)
    end,

    window = {
      layout = "float",
      width = 0.8,
      height = 0.8,
      relative = "editor",
      border = "rounded",
    },

    mappings = {
      close = {
        normal = "q",
        insert = "",
      },

      reset = {
        normal = "<M-r>",
        insert = "<M-r>",
      },

      submit_prompt = {
        normal = "<CR>",
        insert = "<M-s>",
      },

      accept_diff = {
        normal = "<M-a>",
        insert = "",
      },

      yank_diff = {
        normal = "<M-y>",
      },

      complete = {
        insert = "",
      },
    },
  },

  init = function()
    -- Open chat
    vim.keymap.set({ "n", "x" }, "<M-c>", ":CopilotChat<CR>", { noremap = true, silent = true })

    -- Open model selector
    vim.keymap.set({ "n", "x" }, "<M-m>", ":CopilotChatModels<CR>", { noremap = true, silent = true })
  end,
}
