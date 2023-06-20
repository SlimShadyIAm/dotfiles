local map = require("helpers.keys").map

-- Blazingly fast way out of insert mode
map("i", "jk", "<esc>")
map("i", "kj", "<esc>")

-- Fast way to add new line without leaving normal mode
map("n", "<leader><Enter>", "o<esc>", "Add new line")

-- Go back to start of line (first non-whitespace character)
map("n", "2", "^")

-- Quick access to some common actions
map("n", "<leader>ww", "<cmd>w<cr>", "Write")
map("n", "<leader>wa", "<cmd>wa<cr>", "Write all")
map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
-- map("n", "<leader>dw", "<cmd>close<cr>", "Window")

-- source current file
map("n", "<leader>so", "<cmd>so<cr>", "Source file")

-- Diagnostic keymaps
map('n', '<leader>ld', vim.diagnostic.open_float, "Show diagnostics under cursor")
map('n', '<C-]>', function () vim.diagnostic.goto_next() end, "Go to next diagnostic")
map('n', '<C-[>', function () vim.diagnostic.goto_prev() end, "Go to previous diagnostic")

-- Easier access to beginning and end of lines
map("n", "<M-h>", "^", "Go to beginning of line")
map("n", "<M-l>", "$", "Go to end of line")

-- Move with shift-arrows
map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Deleting buffers
local buffers = require("helpers.buffers")
map("n", "<leader>db", buffers.delete_this, "Current buffer")
map("n", "<leader>do", buffers.delete_others, "Other buffers")
map("n", "<leader>da", buffers.delete_all, "All buffers")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Switch between light and dark modes
map("n", "<leader>ut", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, "Toggle between light and dark themes")

-- Clear after search
map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")
