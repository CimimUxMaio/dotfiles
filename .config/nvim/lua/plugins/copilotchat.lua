return {
  "CopilotC-Nvim/CopilotChat.nvim",

  name = "copilot-chat",

  branch = "canary",

  dependencies = {
    "copilot",
    "cmp",
    "telescope",
    "dressing",
    { "nvim-lua/plenary.nvim" },
  },

  build = "make tiktoken",

  opts = {
    show_help = true,
    highlight_selection = false,

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

  config = function(_, opts)
    -- Setup cmp integration
    require("CopilotChat.integrations.cmp").setup()

    local chat = require("CopilotChat")
    chat.setup(opts)

    -- Keybinds
    -- Telescope integration
    vim.keymap.set("n", "<M-p>", function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    end, { noremap = true, silent = true })

    -- Quick question
    vim.keymap.set("n", "<M-'>", function()
      local callback = function(input)
        if input ~= nil and input ~= "" then
          chat.ask(input, { system_prompt = nil, selection = nil }) -- Ask with no instructions, no context
        end
      end

      vim.ui.input({
        prompt = "How can I help you? ",
      }, callback)
    end, { noremap = true, silent = true })

    -- Open chat
    vim.keymap.set({ "n", "x" }, "<M-c>", ":CopilotChat<CR>", { noremap = true, silent = true })
  end,
}
