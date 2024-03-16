return {
  "nvim-telescope/telescope.nvim",

  name = "telescope",

  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local actions = require("telescope.actions")

    -- General configuration
    require("telescope").setup {
      defaults = {
        -- Keymaps for all pickers
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<C-v><C-s>"] = actions.select_vertical,
            ["<C-s>"] = actions.select_horizontal,
          },
        },
      },

      pickers = {
        help_tags = {
          mappings = {
            i = {
              ["<CR>"] = "file_vsplit",
            },
          },
        },

        buffers = {
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
          },
        },
      },
    }

    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "ff", "<cmd>Telescope find_files<CR>", opts)
    vim.api.nvim_set_keymap("n", "fh", "<cmd>Telescope help_tags<CR>", opts)
    vim.api.nvim_set_keymap("n", "fp", "<cmd>Telescope commands<CR>", opts)
    vim.api.nvim_set_keymap("n", "fd", "<cmd>Telescope diagnostics<CR>", opts)
    vim.api.nvim_set_keymap("n", "fs", "<cmd>Telescope live_grep<CR>", opts)
    vim.api.nvim_set_keymap("n", "fb", "<cmd>Telescope buffers<CR>", opts)
  end,
}
