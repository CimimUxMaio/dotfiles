return {
  "windwp/nvim-autopairs",

  name = "autopairs",

  dependencies = { "hrsh7th/nvim-cmp" },

  config = function()
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    require("nvim-autopairs").setup {}
  end,
}
