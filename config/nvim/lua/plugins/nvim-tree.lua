local utils = require("utils")
local nvim_tree = require("nvim-tree")

local signs = utils.icons.signs

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))

  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set("n", "cd", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))

  vim.keymap.set("n", "vs", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "hs", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "t", api.node.open.edit, opts("Open: New Tab"))
  vim.keymap.set(
    "n", "o",
    function()
      local node = api.tree.get_node_under_cursor()
      if node.type == "directory" then
        api.node.open.edit()
      else
        vim.cmd.BufferReplace(node.absolute_path)
      end
    end,
    opts("Open: In Place")
  )
end

-- Use all default plus some extras
nvim_tree.setup {
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = signs.Hint,
      info = signs.Info,
      warning = signs.Warn,
      error = signs.Error
    }
  },

  on_attach = on_attach,

  renderer = {
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      }
    }
  }
}


vim.api.nvim_set_keymap("n", "<leader><Tab>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Auto close NvimTree if it is the last buffer open at :q
vim.cmd [[
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]]
