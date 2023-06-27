-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      vim.opt.signcolumn = "yes"

      require("gitsigns").setup({
        signcolumn = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 250
        },
      })
    end
  },
  {
    "tpope/vim-fugitive",
    event = "BufRead",
    config = function()
      local map = require("helpers.keys").map
      map("n", "<leader>ga", "<cmd>Git add %<cr>", "Stage the current file")
      map("n", "<leader>gb", "<cmd>Git blame<cr>", "Show the blame")
    end
  }
}
