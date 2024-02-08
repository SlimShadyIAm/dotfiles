return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "BufRead",
    config = function()
      local keymap = require("helpers.keys")
      keymap.map("n", "<leader>fs", '<cmd>lua require("spectre").toggle()<CR>', "Project search")
      keymap.map("v", "<leader>fs", '<esc><cmd>lua require("spectre").open_visual()<CR>',
        "Project search current word")
    end
  }
}
