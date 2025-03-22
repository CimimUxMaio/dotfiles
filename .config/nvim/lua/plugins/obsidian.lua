return {
  "epwalsh/obsidian.nvim",

  version = "*", -- Use latest release

  lazy = true,

  ft = "markdown",

  cmd = { "ObsidianSearch", "ObsidianNew" },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },

  opts = {
    workspaces = {
      -- {
      --   name = "Work",
      --   path = "~/.obsidian/vaults/work",
      --   strict = true
      -- },

      {
        name = "Personal",
        path = "~/.obsidian/vaults/personal",
        strict = true,
      },
    },

    notes_subdir = "3 - Notes",

    new_notes_location = "notes_subdir",

    completion = {
      nvim_cmp = true,
    },

    templates = {
      folder = "2 - Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    picker = {
      name = "telescope.nvim",
    },

    attachments = {
      img_folder = "1 - Attachments/images",
    },

    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,

        opts = { noremap = false, buffer = true, expr = true },
      },

      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,

        opts = { buffer = true, expr = true },
      },
    },

    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end

      return tostring(os.time()) .. "-" .. suffix
    end,

    ui = { enable = false },
  },

  init = function()
    vim.api.nvim_set_keymap("n", "fn", ":ObsidianSearch<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "ft", ":ObsidianTags<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>ot", ":ObsidianTemplate<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>op", ":ObsidianPasteImg<CR>", { noremap = true })
  end,
}
