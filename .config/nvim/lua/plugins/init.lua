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

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
    init = function()
      vim.keymap.set("n", "s", "<cmd>HopChar2<cr>", { silent = true, noremap = true })
    end,
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = {
        relative = "editor",
        prefer_width = 0.6,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",

    opts = {
      theme = "auto",
    },
  },

  {
    "numToStr/Comment.nvim",
    opts = {
      ignore = "^$", -- Ignore empty lines.
    },
  },
}
