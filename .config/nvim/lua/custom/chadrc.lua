---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'rosepine',
    statusline = {
    theme = "vscode",
    -- round and block will work for minimal theme only
    separator_style = "default",
    overriden_modules = nil,
  },
  tabufline = {
    enabled = false,
  },
}

M.plugins = "custom.default_plugins"
M.mappings = require "custom.mappings"

return M
