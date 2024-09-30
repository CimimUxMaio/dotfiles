return {
  {
    "lunarvim/darkplus.nvim",
    lazy = false,
    config = function()
      vim.cmd([[colorscheme darkplus]])
    end,
  },

  { "lewis6991/gitsigns.nvim", opts = {} }, -- Use default settings

  "https://tpope.io/vim/fugitive.git",

  "christoomey/vim-tmux-navigator",
}
