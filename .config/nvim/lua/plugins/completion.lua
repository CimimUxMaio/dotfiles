return {
  "saghen/blink.cmp",

  dependencies = { "rafamadriz/friendly-snippets" },

  version = "1.*",

  opts = {
    completion = {
      menu = {
        border = "rounded",
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = "rounded",
        },
      },
    },

    keymap = {
      preset = "super-tab",

      ["<C-j>"] = { "select_next", "fallback_to_mappings" },
      ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
    },

    cmdline = {
      keymap = {
        preset = "super-tab",

        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
      },
    },
  },
}
