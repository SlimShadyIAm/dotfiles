return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      local colors = require("catppuccin.palettes").get_palette('mocha')
      require("toggleterm").setup({
        shade_terminals = false,
        highlights = {
          Normal = {
            guibg = colors.mantle
         }
        }
      })
      local map = require("helpers.keys").map
      map({ "n", "t" }, "<C-\\>", "<cmd>ToggleTerm<cr>", "Open terminal")
    end,
  },
}
