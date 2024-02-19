local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["jk"] = { "<ESC>", "Blazing fast escape" },
  },
  n = {
    ['<leader>qa'] = { "<cmd>qa!<cr>", "Quit all" },
    ['<C-]>']      = { function() vim.diagnostic.goto_next() end, "Go to next diagnostic" },
    ['<C-[>']      = { function() vim.diagnostic.goto_prev() end, "Go to previous diagnostic" },
    ['<Esc>']      = { '<Nop>', "" },
    ['<leader>e']  = { "<cmd>NvimTreeToggle<cr>", "Toggle file explorer" },
  }
}

M.lspconfig = {
  plugin = true,
  n = {
    ['<leader>lr'] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol" },
    ['<leader>la'] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
    ['<leader>lh'] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Type definition" },
    ['<leader>ls'] = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "Document symbols" },
    ['<leader>gd'] = { "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", "Goto Definition" },
    ['<leader>gr'] = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "Goto References" },
    ['<leader>gI'] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
    ['<leader>F'] = { function() vim.lsp.buf.format() end, "Format" },
  }
}

return M
