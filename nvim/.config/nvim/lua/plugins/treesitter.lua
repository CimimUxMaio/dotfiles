return {
  "nvim-treesitter/nvim-treesitter",

  name = "treesitter",
  lazy = false,
  build = ":TSUpdate",

  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
  },

  init = function()
    require("nvim-treesitter").setup()
  end,

  config = function()
    require("nvim-treesitter").install { "lua", "vim", "vimdoc", "diff", "json" }

    require("nvim-ts-autotag").setup {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    }

    require("ts_context_commentstring").setup {
      enable_autocmd = false,
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        local ok, _ = pcall(vim.treesitter.get_parser, 0)
        if ok then
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldlevel = 20
        end
      end,
    })
  end,
}
