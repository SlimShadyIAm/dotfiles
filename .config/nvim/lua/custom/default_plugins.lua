local plugins = {
  {
    "NvChad/nvterm",
    enabled = false
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right"
      },
      actions = {
        open_file = {
          quit_on_open = true
        }
      }
    }
  },
  {
  "neovim/nvim-lspconfig",
   config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
   end,
  },
  {
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "lua-language-server",
        "tsserver",
        "pylsp",
        "stylua"
      },
    },
  },
  require("custom.plugins.auto-save"),
  require("custom.plugins.auto-session"),
  require("custom.plugins.copilot"),
  require("custom.plugins.harpoon"),
  require("custom.plugins.misc"),
  require("custom.plugins.typescript"),
}

return plugins
