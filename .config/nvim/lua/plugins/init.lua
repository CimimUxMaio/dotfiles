return {
  {
    "lunarvim/darkplus.nvim",
    lazy = false,
    config = function()
      vim.cmd([[colorscheme darkplus]])
    end,
  },

  { "lewis6991/gitsigns.nvim", opts = {} }, -- Use default settings

  { "stevearc/dressing.nvim", name = "dressing", lazy = true },

  "https://tpope.io/vim/fugitive.git",

  "christoomey/vim-tmux-navigator",
}
