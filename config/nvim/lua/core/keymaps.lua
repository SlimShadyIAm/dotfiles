local map = require("helpers.keys").map

-- Blazingly fast way out of insert mode
map("i", "jk", "<esc>")

-- Go back to start of line (first non-whitespace character)
map("n", "2", "^")

-- Quick access to some common actions
map("n", "<leader>ww", "<cmd>w<cr>", "Write")
map("n", "<leader>wa", "<cmd>wa<cr>", "Write all")
map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")

-- Diagnostic keymaps
map('n', '<leader>ld', vim.diagnostic.open_float, "Show diagnostics under cursor")
map('n', '<C-]>', function () vim.diagnostic.goto_next() end, "Go to next diagnostic")
map('n', '<C-[>', function () vim.diagnostic.goto_prev() end, "Go to previous diagnostic")

-- Move with shift-arrows
map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

-- Deleting buffers
local buffers = require("helpers.buffers")
map("n", "<leader>db", buffers.delete_this, "Current buffer")
map("n", "<leader>do", buffers.delete_others, "Other buffers")
map("n", "<leader>da", buffers.delete_all, "All buffers")

-- Clear after search
map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")

-- for some reason escape in normal mode makes you jump to the next diagnostic. stop doing this
map('n', '<Esc>', '<Nop>', { noremap = true, silent = true })

-- disable paste on enter
map('n', '<Enter>', '<Nop>', { noremap = true, silent = true })
