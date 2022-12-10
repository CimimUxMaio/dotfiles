local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local get_config = function(name)
  return string.format("require('plugins.%s')", name)
end

local packer = require("packer")

-- For packer to use a popup window.
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end
  }
}

local packer_bootstrap = ensure_packer()

return packer.startup(function(use)
  use "wbthomason/packer.nvim"


  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    run = ":TSUpdate",
    config = get_config("treesitter")
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = get_config("telescope")
  }

  use {
    "nvim-tree/nvim-tree.lua",
    requires = "nvim-tree/nvim-web-devicons",
    config = get_config("nvim-tree")
  }

  use {
    "rcarriga/nvim-notify",
    config = get_config("notify")
  }

  use {
    "lunarvim/darkplus.nvim",
    config = "vim.cmd [[colorscheme darkplus]]"
  }

  use "lukas-reineke/indent-blankline.nvim"

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      { "saadparwaiz1/cmp_luasnip", requires = "L3MON4D3/LuaSnip" },
    },
    config = get_config("completion")
  }

  use {
    "windwp/nvim-autopairs",
    requires = "hrsh7th/nvim-cmp",
    config = get_config("autopairs")
  }

  use {
    "williamboman/mason.nvim",
    requires = {
      "hrsh7th/nvim-cmp",
      "williamboman/mason-lspconfig",
      "neovim/nvim-lspconfig",
    },
    config = get_config("lsp")
  }

  use {
    "akinsho/toggleterm.nvim",
    config = get_config("toggleterm")
  }

  use {
    "nvim-lualine/lualine.nvim",
    config = get_config("lualine")
  }

  use {
    "romgrk/barbar.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = get_config("barbar")
  }

  use {
    "stevearc/dressing.nvim"
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  }

  use {
    "numToStr/Comment.nvim",
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
    config = get_config("comments")
  }

  use {
    "kevinhwang91/nvim-hlslens",
    config = get_config("hlslens")
  }

  use {
    "petertriho/nvim-scrollbar",
    config = get_config("scrollbar"),
    requires = "kevinhwang91/nvim-hlslens"
  }

  use {
    "phaazon/hop.nvim",
    config = get_config("hop")
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = get_config("gitsigns")
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    packer.sync()
  end
end)
