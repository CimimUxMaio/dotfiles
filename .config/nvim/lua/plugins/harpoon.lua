local function get_current_buffer_normalized_path()
  Path = require("plenary.path")
  local buffer = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(buffer)
  local root = vim.loop.cwd()
  return Path:new(buf_name):make_relative(root)
end

local function harpoon_contains_current()
  local harpoon = require("harpoon")
  local current_file = get_current_buffer_normalized_path()
  for _, item in ipairs(harpoon:list().items) do
    local file_name = item.value
    if file_name == current_file then
      return true
    end
  end
  return false
end

return {
  "ThePrimeagen/harpoon",

  name = "harpoon",

  branch = "harpoon2",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "telescope",
  },

  config = function()
    local harpoon = require("harpoon")
    harpoon.setup()

    -- General mappings
    vim.keymap.set("n", "M", function()
      -- If the current file is in the list, remove it from the list
      -- if not, add it.
      if harpoon_contains_current() then
        harpoon:list():remove()
      else
        harpoon:list():append()
      end
    end, { desc = "Mark / Unmark file" })

    vim.keymap.set("n", "<leader><leader>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle Harpoon window" })

    vim.keymap.set("n", "J", function()
      harpoon:list():next()
    end, { desc = "Open next marked file" })

    vim.keymap.set("n", "K", function()
      harpoon:list():prev()
    end, { desc = "Open previous marked file" })

    -- Harpoon window mappings
    harpoon:extend {
      UI_CREATE = function(ctx)
        for n = 1, 9 do
          vim.keymap.set("n", tostring(n), function()
            harpoon:list():select(n)
          end, { buffer = ctx.bufnr, desc = "Select mark " .. tostring(n) })
        end
      end,
    }

    vim.g.harpoon_loaded = true
  end,
}
