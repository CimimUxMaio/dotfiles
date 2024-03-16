return {
  "stevearc/oil.nvim",

  name = "oil",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require("oil").setup {
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v><C-s>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        -- ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        [".."] = "actions.parent",
        ["_"] = "actions.open_cwd",
        -- ["`"] = "actions.cd",
        -- ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    }

    vim.api.nvim_set_keymap(
      "n",
      "<leader><Tab>",
      ":Oil<CR>",
      { noremap = true, silent = true, desc = "Open parent directory" }
    )
  end,
}
