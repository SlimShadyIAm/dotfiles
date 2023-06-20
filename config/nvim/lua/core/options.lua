local opts = {
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  wrap = false,
  termguicolors = true,
  number = true,
  relativenumber = true,
  smartindent = true,
  autoindent = true,
  scrolloff = 12,
  signcolumn = 'yes',
}

for opt, val in pairs(opts) do
  vim.o[opt] = val
end

-- Set other options
local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)
vim.api.nvim_create_autocmd("VimEnter", {
  command = "set nornu nonu | set number | set relativenumber",
})

-- use system clipboard as the default register
vim.api.nvim_create_autocmd("VimEnter", {
  command = "set clipboard=unnamedplus",
})

-- vim.diagnostic.config({
--   virtual_text = false,
-- })

