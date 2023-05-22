local configs = require("nvim-treesitter.configs")

configs.setup {
  ensure_installed = "all",
  sync_install = false,
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = {},
    aditional_vim_regex_highlighting = true
  },

  indent = { enable = true, disable = {} },

  context_commentstring = {
    enable = true
  },

  autotag = {
    enable = true
  },

  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<leader>r"
      }
    }
  }
}

-- Enable code folding using treesitter
local opt = vim.opt

opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
