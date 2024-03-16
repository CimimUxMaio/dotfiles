return {
  "petertriho/nvim-scrollbar",

  name = "scrollbar",

  dependencies = { "hlslens" },

  config = function()
    require("scrollbar").setup {
      handle = {
        color = "#BBBBBB",
      },
    }

    require("scrollbar.handlers.search").setup()
  end,
}
