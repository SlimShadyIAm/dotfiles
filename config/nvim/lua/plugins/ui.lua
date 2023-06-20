return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local ident = require("indent_blankline")
      ident.setup()
    end,
  },
  -- {
  --   "ErichDonGubler/lsp_lines.nvim",
  --   config = function()
  --     local lsplines = require("lsp_lines")
  --     lsplines.setup()
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        copy_sync = {
          enable = false,
        },
        navigation = {
          cycle_navigation = false,
        },
        resize = {
          resize_step_x = 5,
          resize_step_y = 5,
        }
      })

      local map = require('helpers.keys').map
      -- move between buffers/tmux panes
      map({ "n", "i", "t" }, "<C-h>", function() require("tmux").move_left() end)
      map({ "n", "i", "t" }, "<C-j>", function() require("tmux").move_bottom() end)
      map({ "n", "i", "t" }, "<C-k>", function() require("tmux").move_top() end)
      map({ "n", "i", "t" }, "<C-l>", function() require("tmux").move_right() end)

      map({ "n", "i", "t" }, "<M-h>", function() require("tmux").resize_left() end)
      map({ "n", "i", "t" }, "<M-j>", function() require("tmux").resize_bottom() end)
      map({ "n", "i", "t" }, "<M-k>", function() require("tmux").resize_top() end)
      map({ "n", "i", "t" }, "<M-l>", function() require("tmux").resize_right() end)
    end
  },
	{
		"petertriho/nvim-scrollbar",
		config = function()
			local scrollbar = require("scrollbar")
			scrollbar.setup()
		end,
	},
}
