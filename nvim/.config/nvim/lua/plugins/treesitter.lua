return {
  "nvim-treesitter/nvim-treesitter",

  name = "treesitter",
  lazy = false,
  build = ":TSUpdate",

  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
  },

  config = function()
    -- Install parsers asynchronously
    require("nvim-treesitter").install { "lua", "vim", "vimdoc", "diff", "json" }

    -- Plugin dependencies setup
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

    -- FileType autocommand for built-in treesitter features
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_setup", { clear = true }),
      pattern = { "*" },
      callback = function(args)
        local buf = args.buf

        -- Safely attach treesitter highlighter.
        -- pcall prevents throwing errors when no parser exists for a buffer (e.g., Telescope prompt/results)
        local has_parser = pcall(vim.treesitter.start, buf)

        if has_parser then
          -- Set built-in folding and experimental indenting only if a parser is active
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldlevel = 20
        end
      end,
    })
  end,
}
