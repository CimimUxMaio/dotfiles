return {
  "MeanderingProgrammer/markdown.nvim",

  lazy = true,

  ft = "markdown",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    lsp = { enabled = true },

    heading = {
      enabled = true,
      position = "inline",
      border = true,
    },
  },
}
