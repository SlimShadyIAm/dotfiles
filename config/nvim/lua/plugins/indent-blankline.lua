return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      local indent = require("indent_blankline")
      indent.setup({
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },
}
