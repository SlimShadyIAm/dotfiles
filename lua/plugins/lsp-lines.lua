return {
  {
    "ErichDonGubler/lsp_lines.nvim",
    config = function()
      local lsplines = require("lsp_lines")
      lsplines.setup()
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },
}
