return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local ident = require("indent_blankline")
      ident.setup()
    end,
  },
  {
    "ErichDonGubler/lsp_lines.nvim",
    config = function()
      local lsplines = require("lsp_lines")
      lsplines.setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  }
}
