return {
  "zbirenbaum/copilot.lua",

  name = "copilot",

  event = "InsertEnter",

  config = function()
    require("copilot").setup {
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "<M-k>",
          jump_next = "<M-j>",
          accept = "<CR>",
          refresh = "<M-r>",
          open = "<M-p>",
        },
        layout = {
          position = "right", -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-a>",
          accept_word = false,
          accept_line = false,
          next = "<M-j>",
          prev = "<M-k>",
          dismiss = "<M-d>",
        },
      },
      filetypes = {
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = "node", -- Node.js version must be > 16.x
      server_opts_overrides = {},
    }
  end,
}
