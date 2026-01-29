local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<C-c>", "<Esc>", opts)
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", opts)

-- Moving between windows
vim.api.nvim_set_keymap("n", "<C-j>", "<C-W><C-j>", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-W><C-k>", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-W><C-l>", opts)
vim.api.nvim_set_keymap("n", "<C-h>", "<C-W><C-h>", opts)

-- Rezising windows
-- M: Alt
vim.api.nvim_set_keymap("n", "<M-j>", ":resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<M-k>", ":resize +2<CR>", opts)
vim.api.nvim_set_keymap("n", "<M-h>", ":vertical resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<M-l>", ":vertical resize +2<CR>", opts)

-- Window Splits
vim.api.nvim_set_keymap("n", "<C-s>", ":split<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-v><C-s>", ":vsplit<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-z>", ":only<CR>", opts)

-- Better tabing
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)

-- Buffer navigation
vim.api.nvim_set_keymap("n", "H", ":bprevious<CR>", opts)
vim.api.nvim_set_keymap("n", "L", ":bnext<CR>", opts)
vim.api.nvim_set_keymap("n", "Q", ":bdelete<CR>", opts)
vim.keymap.set("n", "<leader>Q", function() -- Close all buffers except the current one
  local buffers = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(buffers) do
    if buf ~= current_buf then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, opts)
