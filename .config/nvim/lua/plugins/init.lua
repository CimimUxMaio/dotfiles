return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd([[
        colorscheme catppuccin-mocha
      ]])
    end,
  },

  { "lewis6991/gitsigns.nvim" },

  "https://tpope.io/vim/fugitive.git",

  "christoomey/vim-tmux-navigator",
}
