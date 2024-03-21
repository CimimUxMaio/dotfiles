return {
  "phaazon/hop.nvim",

  name = "hop",

  config = function()
    require("hop").setup()

    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "s", ":HopChar2<CR>", opts)
  end,
}
